import 'package:conta_ponto/constants.dart';
import 'package:flutter/material.dart';

///A round button. Accepts a custom [size] and [color], an optional [child] and a [onPressed] function.
class RoundButton extends StatelessWidget {
  final double size;
  final Color color;
  final Widget? child;
  final Function()? onPressed;

  ///Creates a round button. Accepts a custom [size] and [color], an optional [child] and a [onPressed] function.
  const RoundButton({
    Key? key,
    this.size = 40.0,
    this.color = UIColors.roundButton,
    this.child,
    this.onPressed,
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
    );
  }
}
