import 'package:flutter/material.dart';
import 'package:conta_ponto/constants.dart';
import 'package:flutter/services.dart';
import 'round_button.dart';

///A counter for integer numbers. Cannot go below 0.
class Counter {
  int index;
  int value = 0;

  ///Create a counter that starts at 0 and receives an [index] to be displayed.
  Counter({required this.index});

  ///Creates a counter that starts at [value] and receives an [index] to be displayed.
  Counter.withValue({required this.index, required this.value});

  ///Increments the value of the counter by [number].
  ///Decrements if it's negative. Cannot go below 0 or above 999.
  void increment(int number) {
    //Ensures it's not going below 0.
    if (value + number >= 0 && value + number < 1000) value += number;
  }

  ///Sets the counter value to a [newValue].
  void setValue(int? newValue) => value = newValue ?? value;
}

class CounterListController {
  List<Counter> list = [];

  ///Adds an [amount] of new counters at the end of the list. Can't have more than 999 counters.
  void addToList(int amount) {
    if (list.length + amount <= 999) {
      for (int i = 0; i < amount; i++) {
        list.add(Counter(index: list.length));
      }
    }
  }

  ///Deletes a counter at [index] and its tile from the list, updating all subsequent indexes accordingly.
  void deleteCounter(int index) {
    if (index < list.length) {
      for (int i = index; i < list.length - 1; i++) {
        list[i].value = list[i + 1].value;
      }
      list.removeLast();
    }
  }
  //setState() => _listController.deleteCounter(index);
  //saveToPrefs;
}

///The UI tile that shows a counter's info.
class CounterTile extends StatelessWidget {
  final Counter counter;

  ///Function to update the numbers on the screen.
  final Function() updateFunction;

  ///Function to delete the counter and its tile.
  final Function(int) deleteFunction;

  const CounterTile({
    Key? key,
    required this.counter,
    required this.updateFunction,
    required this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Button to delete the counter.
          RoundButton(
            child: const Icon(Icons.close),
            onPressed: () => deleteFunction(counter.index),
          ),
          //Container with the index number. Displayed index starts at 1.
          Container(
            //Width should be able to fit 3 digits
            width: 80,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerRight,
            child: Text(
              (counter.index + 1).toString(),
              style: (counter.index < 99
                  ? Theme.of(context).textTheme.displayLarge
                  : Theme.of(context).textTheme.displayMedium),
            ),
          ),
          //Button to decrement from the counter.
          const SizedBox(width: 0),
          RoundButton(
            size: 32,
            child: const Icon(Icons.remove),
            onPressed: () {
              counter.increment(-1);
              updateFunction.call();
            },
          ),
          //Counter value display. Can be tapped to edit value directly.
          InkWell(
            child: SizedBox(
              //Width should be able to fit 3 digits
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    UITextStrings.counterLabel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    counter.value.toString(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
            onTap: (() {
              //-1 is used if an invalid number is entered.  it's used instead of null for comparison purposes
              int newValue = -1;
              showDialog(
                context: context,
                builder: (BuildContext context) => StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    title: const Text(UITextStrings.dialogTitleSetCounter),
                    //This TextField only accepts number input
                    content: TextField(
                      //TODO add errortext
                      autofocus: true,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                        hintText: counter.value.toString(),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
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
                          newValue = int.tryParse(value) ?? -1;
                          if (newValue > 999 || newValue < 0) newValue = -1;
                        });
                      },
                    ),
                    actions: <TextButton>[
                      //"Cancel" button
                      TextButton(
                        child: Text(
                          UITextStrings.dialogButtonCancel,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                      ),
                      //"OK" button, only available if value entered is a number >= 0
                      TextButton(
                        child: Text(
                          UITextStrings.dialogButtonOK,
                          style: newValue >= 0
                              ? Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary)
                              : Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
                        onPressed: newValue >= 0
                            ? () {
                                counter.setValue(newValue);
                                updateFunction.call();
                                Navigator.pop(context, 'OK');
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          //Button to increment from the counter.
          RoundButton(
            size: 32,
            child: const Icon(Icons.add),
            onPressed: () {
              counter.increment(1);
              updateFunction.call();
            },
          ),
        ],
      ),
    );
  }
}
