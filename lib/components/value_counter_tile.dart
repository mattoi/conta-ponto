import 'package:conta_ponto/constants.dart';
import 'package:flutter/material.dart';
import 'round_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//TODO maybe add a button to enter custom number (via a popup)

class Counter {
  int index;
  int value = 0;

  Counter(this.index, {this.value = 0});

  Counter.withValue(this.index, {this.value = 0});

  void decrement(int a) {
    if (value > 0) value -= a;
  }

  void increment(int a) => value += a;
}

class CounterTile extends StatelessWidget {
  final Color color;
  final Counter counter;
  final Function(Counter)? updateFunction;
  final Function(int) deleteFunction;

  const CounterTile({
    required this.counter,
    required this.color,
    required this.updateFunction,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundIconButton(
            // delete counter button
            color: Color(0xFF0A0E20),
            child: const Icon(FontAwesomeIcons.minus),
            onPressed: () {
              return deleteFunction(counter.index);
            },
          ),
          Container(
            //index number
            width: 100,
            height: 94,
            alignment: Alignment.centerRight,
            child: Text(
              (counter.index + 1).toString(),
              style: (counter.index < 99
                  ? UITextStyles.index
                  : UITextStyles.index.copyWith(fontSize: 58)),
            ),
          ),
          const SizedBox(width: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PONTO',
                style: UITextStyles.label,
              ),
              Text(
                counter.value.toString(),
                style: UITextStyles.number,
              ),
            ],
          ),
          const SizedBox(width: 16),
          RoundIconButton(
            child: const Icon(FontAwesomeIcons.minus),
            onPressed: () {
              counter.decrement(1);
              updateFunction?.call(counter);
              // TODO maybe refactor these round buttons into something more concise
            },
          ),
          const SizedBox(width: 8),
          RoundIconButton(
            child: const Icon(FontAwesomeIcons.plus),
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
