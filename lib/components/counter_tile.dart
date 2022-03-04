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
  ///Decrements if it's negative, but cannot go below 0.
  void increment(int number) {
    //Ensures it's not going below 0.
    if (value + number >= 0 && value + number < 1000) value += number;
  }

  ///Sets the counter value to a [newValue].
  void setValue(int? newValue) => value = newValue ?? value;
}

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
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          color: UIColors.counterTile, borderRadius: BorderRadius.circular(10)),
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
                  ? UITextStyles.indexNumber
                  : UITextStyles.indexNumber
                      .copyWith(fontSize: 38, fontWeight: FontWeight.w900)),
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
            onTap: (() {
              //-1 is used if an invalid number is entered.  it's used instead of null for comparison purposes
              int newValue = -1;
              showDialog(
                context: context,
                builder: (BuildContext context) => StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    backgroundColor: UIColors.counterTile,
                    title: const Text(
                      UITextStrings.dialogTitleSetCounter,
                      style: UITextStyles.dialogTitle,
                    ),
                    //This TextField only accepts number input
                    content: TextField(
                      autofocus: true,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
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
                        setState(() {
                          newValue = int.tryParse(value) ?? -1;
                          if (newValue > 999) newValue = -1;
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
                          style: newValue >= 0
                              ? UITextStyles.dialogButton
                              : UITextStyles.dialogButton
                                  .copyWith(color: UIColors.labelText),
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
