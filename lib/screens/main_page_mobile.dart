import 'package:flutter/material.dart';
import 'package:conta_ponto/constants.dart';
import 'package:conta_ponto/components/counter_tile.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPageMobile extends StatefulWidget {
  const MainPageMobile({Key? key}) : super(key: key);

  @override
  _MainPageMobileState createState() => _MainPageMobileState();
}

class _MainPageMobileState extends State<MainPageMobile> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<Counter> _counterList = [];
  final _controller = ScrollController();

  ///Loads the list of saved counters, if any, from shared preferences.
  void loadFromPrefs() async {
    final prefs = await _prefs;
    final List<String>? list = prefs.getStringList('counter_list');
    if (list != null) {
      for (int i = 0; i < list.length; i++) {
        setState(() {
          _counterList
              .add(Counter.withValue(index: i, value: int.parse(list[i])));
        });
      }
    }
  }

  ///Saves all counters as a list into shared preferences.
  void saveToPrefs() async {
    final prefs = await _prefs;
    List<String> list = [];
    for (var i = 0; i < _counterList.length; i++) {
      list.add(_counterList[i].value.toString());
    }
    prefs.setStringList('counter_list', list);
  }

  ///Adds a new counter at the end of the list. Can't have more than 999 counters.
  void _addNewCounter() {
    if (_counterList.length < 999) {
      setState(() => _counterList.add(Counter(index: _counterList.length)));
      saveToPrefs();
      _scrollDown();
    }
  }

  ///Adds an [amount] of new counters at the end of the list. Can't have more than 999 counters.
  void _addMultipleCounters(int amount) {
    if (_counterList.length + amount <= 999) {
      setState(() {
        for (int i = 0; i < amount; i++) {
          _counterList.add(Counter(index: _counterList.length));
        }
      });
      saveToPrefs();
      _scrollDown();
    }
  }

  ///Scrolls down the view, with an animation, to the last element. Usually called when a new counter is added.
  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent + 106,
      duration: const Duration(seconds: 1, milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  ///Deletes a counter at [index] and its tile from the list, updating all subsequent indexes accordingly.
  void _deleteCounter(int index) {
    if (index < _counterList.length) {
      setState(() {
        for (int i = index; i < _counterList.length - 1; i++) {
          _counterList[i].value = _counterList[i + 1].value;
        }
        _counterList.removeLast();
      });
      saveToPrefs();
    }
  }

  ///Calls setState to redraw the values on screen and saves them into shared preferences.
  // Honestly I can't remember who implemented it like this or whether it's
  // optimal or not, but it works.
  void _updateCounter() {
    setState(() {
      saveToPrefs();
    });
  }

  @override
  void initState() {
    super.initState();
    loadFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          UITextStrings.appName,
          style: UITextStyles.appBar,
        ),
        backgroundColor: UIColors.appBar,
        actions: [
          //Button to delete all counters.
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _counterList.isNotEmpty
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        backgroundColor: UIColors.counterTile,
                        title: const Text(
                          UITextStrings.dialogTitleDeleteAll,
                          style: UITextStyles.dialogTitle,
                        ),
                        content: const Text(
                          UITextStrings.dialogContentDeleteAll,
                          style: UITextStyles.dialogContent,
                        ),
                        actions: [
                          //"No" button
                          TextButton(
                            child: const Text(
                              UITextStrings.dialogButtonNo,
                              style: UITextStyles.dialogButton,
                            ),
                            onPressed: () => Navigator.pop(context, 'No'),
                          ),
                          //"Yes" button
                          TextButton(
                            child: const Text(
                              UITextStrings.dialogButtonYes,
                              style: UITextStyles.dialogButton,
                            ),
                            onPressed: () {
                              setState(() => _counterList.clear());
                              Navigator.pop(context, 'Yes');
                            },
                          ),
                        ],
                      ),
                    )
                  : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(UITextStrings.emptyListSnackBar)));
            },
          ),
        ],
      ),
      //Floating button to add a counter. Can be held to add an [amount] of counters.
      floatingActionButton: InkWell(
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: UIColors.actionButton,
          onPressed: _addNewCounter,
        ),
        onLongPress: () {
          int amount = -1;
          showDialog(
            context: context,
            builder: (BuildContext context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                backgroundColor: UIColors.counterTile,
                title: const Text(
                  UITextStrings.dialogTitleAddMultiple,
                  style: UITextStyles.dialogTitle,
                ),
                //This TextField only accepts number input
                content: TextField(
                  autofocus: true,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  cursorColor: UIColors.actionButton,
                  decoration: const InputDecoration(
                    hintText: UITextStrings.addMultipleHintText,
                    hintStyle: UITextStyles.dialogTextFieldHint,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: UIColors.actionButton,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      amount = int.tryParse(value) ?? -1;
                      if (amount + _counterList.length > 999) amount = -1;
                    });
                  },
                ),
                actions: <TextButton>[
                  //"Cancel" button
                  TextButton(
                    child: const Text(
                      UITextStrings.dialogButtonCancel,
                      style: UITextStyles.dialogButton,
                    ),
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                  ),
                  //"OK" button, only available if value entered is a number >= 0
                  TextButton(
                    child: Text(
                      UITextStrings.dialogButtonOK,
                      style: amount >= 1
                          ? UITextStyles.dialogButton
                          : UITextStyles.dialogButton
                              .copyWith(color: UIColors.labelText),
                    ),
                    onPressed: amount >= 1
                        ? () {
                            _addMultipleCounters(amount);
                            Navigator.pop(context, 'OK');
                          }
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      //ListView that generates all the tiles for the counters.
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80),
        shrinkWrap: true,
        itemCount: _counterList.length,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) => CounterTile(
          counter: _counterList[index],
          updateFunction: _updateCounter,
          deleteFunction: _deleteCounter,
        ),
      ),
    );
  }
}
