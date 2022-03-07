import 'package:flutter/material.dart';

///A round button. Accepts a custom [size] and [color], an optional [child], [onPressed] and [onLongPress] functions.
class RoundButton extends StatelessWidget {
  final double size;
  final Color color;
  final Widget? child;
  final Function()? onPressed;
  final Function()? onLongPress;

  ///Creates a round button. Accepts a custom [size] and [color], an optional [child], [onPressed] and [onLongPress] functions.
  const RoundButton({
    Key? key,
    this.size = 40.0,
    this.color = const Color(0xFF4C4F5E),
    this.child,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: size, height: size),
      shape: const CircleBorder(),
      elevation: 0,
      fillColor: color,
      child: child,
      onPressed: onPressed,
      onLongPress: onLongPress,
    );
  }
}
