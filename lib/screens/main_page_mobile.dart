import 'package:flutter/material.dart';
import 'package:conta_ponto/constants.dart';
import 'package:conta_ponto/components/value_counter_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO button to delete all tiles (floating?)
class MainPageMobile extends StatefulWidget {
  const MainPageMobile({Key? key}) : super(key: key);

  @override
  _MainPageMobileState createState() => _MainPageMobileState();
}

class _MainPageMobileState extends State<MainPageMobile> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<Counter> _counterList = [];

  void loadFromPrefs() async {
    final prefs = await _prefs;
    final List<String>? items = prefs.getStringList('items');
    if (items != null) {
      for (int i = 0; i < items.length; i++) {
        setState(() {
          _counterList.add(Counter.withValue(i, value: int.parse(items[i])));
        });
      }
    }
  }

  void saveToPrefs() async {
    final prefs = await _prefs;
    List<String> stringList = [];
    for (var i = 0; i < _counterList.length; i++) {
      stringList.add(_counterList[i].value.toString());
    }
    prefs.setStringList('items', stringList);
  }

  void _addNewCounter() {
    setState(() => _counterList.add(Counter(_counterList.length)));
    saveToPrefs();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta ponto'),
        backgroundColor: UIColors.appBar,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: UIColors.actionButton,
        onPressed: _addNewCounter,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _counterList.length,
        itemBuilder: (BuildContext context, int index) => CounterTile(
          color: UIColors.tile,
          counter: _counterList[index],
          updateFunction: _updateCounter,
          deleteFunction: _deleteCounter,
        ),
        padding: const EdgeInsets.only(bottom: 80),
      ),
    );
  }
}
