import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:conta_ponto/constants.dart';
import 'package:conta_ponto/components/counter_tile.dart';
import 'package:conta_ponto/components/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPageMobile extends StatefulWidget {
  const MainPageMobile({Key? key}) : super(key: key);

  @override
  _MainPageMobileState createState() => _MainPageMobileState();
}

class _MainPageMobileState extends State<MainPageMobile> {
  final _listController = CounterListController();
  final _scrollController = ScrollController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ///Loads the list of saved counters, if any, from shared preferences.
  void _loadFromPrefs() async {
    final prefs = await _prefs;
    final List<String>? cachedList = prefs.getStringList('counter_list');
    if (cachedList != null) {
      setState(() {
        for (int i = 0; i < cachedList.length; i++) {
          _listController.list.add(
              Counter.withValue(index: i, value: int.parse(cachedList[i])));
        }
      });
    }
  }

  ///Saves all counters as a list into shared preferences.
  void _saveToPrefs() async {
    final prefs = await _prefs;
    List<String> savedList = [];
    for (var i = 0; i < _listController.list.length; i++) {
      savedList.add(_listController.list[i].value.toString());
    }
    prefs.setStringList('counter_list', savedList);
  }

  ///Scrolls down the view, with an animation, to the last element. Usually called when a new counter is added.
  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 104,
      duration: const Duration(seconds: 1, milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text(UITextStrings.appName),
        actions: [
          //Button to delete all counters.
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              if (_listController.list.isNotEmpty) {
                final result = await showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      UITextStrings.dialogTitleDeleteAll,
                    ),
                    content: const Text(
                      UITextStrings.dialogContentDeleteAll,
                    ),
                    actions: [
                      //"No" button
                      TextButton(
                        child: Text(
                          UITextStrings.dialogButtonNo,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () => Navigator.pop(context, 'No'),
                      ),
                      //"Yes" button
                      TextButton(
                        child: Text(
                          UITextStrings.dialogButtonYes,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () {
                          Navigator.pop(context, 'Yes');
                        },
                      ),
                    ],
                  ),
                );
                if (result == 'Yes') {
                  setState(() => _listController.list.clear());
                  _saveToPrefs();
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(UITextStrings.emptyListSnackBar)));
              }
            },
          ),
        ],
      ),
      //Floating button to add a counter. Can be held to add an [amount] of counters.
      floatingActionButton: GestureDetector(
        child: RoundButton(
          diameter: 48,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.add, color: Colors.white),
          //tooltip: UITextStrings.actionButtonTooltip,
          onPressed: () {
            setState(() => _listController.addToList(1));
            _saveToPrefs();
            _scrollDown();
          },
        ),
        onLongPress: () async {
          int amount = -1;
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: const Text(UITextStrings.dialogTitleAddMultiple),
                //This TextField only accepts number input
                content: TextField(
                  style: Theme.of(context).textTheme.bodyMedium,

                  //TODO add errortext
                  autofocus: true,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: InputDecoration(
                    hintText: UITextStrings.addMultipleHintText,
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      amount = int.tryParse(value) ?? -1;
                      if (amount + _listController.list.length > 999) {
                        amount = -1;
                      }
                    });
                  },
                ),
                actions: <TextButton>[
                  //"Cancel" button
                  TextButton(
                    child: Text(
                      UITextStrings.dialogButtonCancel,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                  ),
                  //"OK" button, only available if value entered is a number >= 0
                  TextButton(
                    child: Text(
                      UITextStrings.dialogButtonOK,
                      style: amount >= 1
                          ? Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.secondary)
                          : Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface),
                    ),
                    onPressed:
                        amount >= 1 ? () => Navigator.pop(context, 'OK') : null,
                  ),
                ],
              ),
            ),
          );
          if (result == 'OK') {
            setState(() => _listController.addToList(amount));
            _saveToPrefs();
            //TODO scroll is not going all the way down after confirming. it seems to try to go to the last known "bottom" position
            _scrollDown();
          }
        },
      ),
      //ListView that generates all the tiles for the counters.
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80, top: 8),
        shrinkWrap: true,
        itemCount: _listController.list.length,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) => CounterTile(
          counter: _listController.list[index],
          updateFunction: () {
            // setState with an expression body into an async function causes an exception.
            setState(() {
              _saveToPrefs();
            });
          },
          deleteFunction: (index) {
            setState(() => _listController.removeAt(index));
            _saveToPrefs();
          },
        ),
      ),
    );
  }
}
