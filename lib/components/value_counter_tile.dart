import 'package:conta_ponto/constants.dart';
import 'package:flutter/material.dart';
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
  ///Decrements if it's negative, but cannot go below 0.
  void increment(int number) {
    //Ensures it's not going below 0.
    if (value + number >= 0) value += number;
  }

  ///Sets the counter value to a [number].
  void setValue(int? number) => value = number ?? value;
}

class CounterTile extends StatelessWidget {
  final Counter counter;

  ///Function to update the numbers on the screen.
  final Function(Counter)? updateFunction;

  ///Function to delete the counter and its tile.
  final Function(int) deleteFunction;

  const CounterTile({
    Key? key,
    required this.counter,
    required this.updateFunction,
    required this.deleteFunction,
  }) : super(key: key);

  //Pretty sure I was told this kind of refactoring is bad, but I can't remember why.
  //This is easier to edit for now.

  @override
  Widget build(BuildContext context) {
    //TODO fix all of the component sizes, margins and sizedboxes here. Layout is a bit weird
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: UIColors.counterTile, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Button to delete the counter.
          RoundButton(
            child: const Icon(Icons.remove),
            onPressed: () => deleteFunction(counter.index),
          ),
          //Container with the index number. Displayed index starts at 1.
          Container(
            width: 80,
            height: 94,
            alignment: Alignment.centerRight,
            child: Text(
              (counter.index + 1).toString(),
              style: (counter.index < 99
                  ? UITextStyles.indexNumber
                  : UITextStyles.indexNumber.copyWith(fontSize: 52)),
            ),
          ),
          const SizedBox(width: 16),
          //Counter value display. Can be tapped to edit value directly.
          InkWell(
            onTap: (() {
              int newValue = counter.value;
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  backgroundColor: UIColors.counterTile,
                  title: const Text(
                    UITextStrings.dialogTitleSetCounter,
                    style: UITextStyles.dialogTitle,
                  ),
                  content: TextField(
                    //TODO implement handling bad input values. Currently it doesn't crash, but just ignores them
                    autofocus: true,
                    cursorColor: UIColors.actionButton,
                    decoration: const InputDecoration(
                      hintText: UITextStrings.dialogTextFieldHint,
                      hintStyle: UITextStyles.dialogTextFieldHint,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: UIColors.actionButton,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      newValue = int.tryParse(value) ?? newValue;
                    },
                  ),
                  actions: <TextButton>[
                    //Cancel button
                    TextButton(
                      child: const Text(
                        UITextStrings.dialogButtonCancel,
                        style: UITextStyles.dialogButton,
                      ),
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                    ),
                    //OK button
                    TextButton(
                      child: const Text(
                        UITextStrings.dialogButtonOK,
                        style: UITextStyles.dialogButton,
                      ),
                      onPressed: () {
                        if (newValue >= 0) {
                          counter.setValue(newValue);
                          updateFunction?.call(counter);
                        }
                        Navigator.pop(context, 'OK');
                      },
                    ),
                  ],
                ),
              );
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  UITextStrings.counterLabel,
                  style: UITextStyles.label,
                ),
                Text(
                  counter.value.toString(),
                  style: UITextStyles.counterValue,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          //Button to decrement from the counter.
          RoundButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              counter.increment(-1);
              updateFunction?.call(counter);
            },
          ),
          const SizedBox(width: 4),
          //Button to increment from the counter.
          RoundButton(
            child: const Icon(Icons.add),
            onPressed: () {
              counter.increment(1);
              updateFunction?.call(counter);
            },
          ),
        ],
      ),
    );
  }
}
