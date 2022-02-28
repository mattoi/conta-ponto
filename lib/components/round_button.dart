import 'package:conta_ponto/constants.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final double size;
  final Color color;
  final Widget? child;
  final Function() onPressed;

  const RoundButton({
    Key? key,
    this.size = 40.0,
    this.color = UIColors.roundButton,
    this.child,
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
