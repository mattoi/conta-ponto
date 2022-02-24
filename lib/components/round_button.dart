import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final double size;
  final Color color;
  final Widget child;
  final Function() onPressed;
  static const defaultColor = Color(0xFF4C4F5E);

  const RoundIconButton({
    Key? key,
    this.size = 48.0,
    this.color = defaultColor,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: size, height: size),
      shape: const CircleBorder(),
      elevation: 0,
      fillColor: const Color(0xFF4C4F5E),
      child: child,
      onPressed: onPressed,
    );
  }
}
