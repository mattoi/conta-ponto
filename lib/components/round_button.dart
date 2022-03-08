import 'package:flutter/material.dart';

///A round button. Accepts a custom [diameter] and [backgroundColor], an optional [child], [onPressed] and [onLongPress] functions.
class RoundButton extends StatelessWidget {
  final double diameter;
  final Color backgroundColor;
  final Widget? child;
  final Function()? onPressed;
  final Function()? onLongPress;

  ///Creates a round button. Accepts a custom [diameter] and [backgroundColor], an optional [child], [onPressed] and [onLongPress] functions.
  const RoundButton({
    Key? key,
    this.diameter = 40.0,
    this.backgroundColor = const Color(0xFF4C4F5E),
    this.child,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: diameter, height: diameter),
      shape: const CircleBorder(),
      elevation: 0,
      fillColor: backgroundColor,
      child: child,
      onPressed: onPressed,
      onLongPress: onLongPress,
    );
  }
}
