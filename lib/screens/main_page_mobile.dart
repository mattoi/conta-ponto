import 'package:flutter/material.dart';
import 'package:conta_ponto/constants.dart';
import 'package:conta_ponto/components/value_counter_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPageMobile extends StatefulWidget {
  const MainPageMobile({Key? key}) : super(key: key);

  @override
  _MainPageMobileState createState() => _MainPageMobileState();
}

class _MainPageMobileState extends State<MainPageMobile> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<Counter> _counterList = [];

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

  ///Adds a new counter at the end of the list.
  void _addNewCounter() {
    setState(() => _counterList.add(Counter(index: _counterList.length)));
    saveToPrefs();
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

  ///Calls setState to redraw the values on screen and saves into shared preferences.
  // Honestly I don't know who implemented it like this or whether it's
  // optimal or not, but it works.
  void _updateCounter(Counter counter) {
    setState(() {
      _counterList[counter.index] = counter;
      saveToPrefs();
    });
  }

  @override
  void initState() {
    super.initState();
    loadFromPrefs();
  }

  //Pretty sure I was told this kind of refactoring is bad, but I can't remember why.
  //This is easier to edit for now.
  AlertDialog showDeleteAllDialog(BuildContext context) {
    return AlertDialog(
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
        //No button
        TextButton(
          child: const Text(
            UITextStrings.dialogButtonNo,
            style: UITextStyles.dialogButton,
          ),
          onPressed: () => Navigator.pop(context, 'No'),
        ),
        //Yes button
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
    );
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
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => showDeleteAllDialog(context),
            ),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      //Floating button to add a counter.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: UIColors.actionButton,
        onPressed: _addNewCounter,
      ),
      //ListView that generates all the tiles for the counters.
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _counterList.length,
        itemBuilder: (BuildContext context, int index) => CounterTile(
          counter: _counterList[index],
          updateFunction: _updateCounter,
          deleteFunction: _deleteCounter,
        ),
        padding: const EdgeInsets.only(bottom: 80),
      ),
    );
  }
}
