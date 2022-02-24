import 'package:flutter/material.dart';

abstract class UIColors {
  static const tile = Color(0xFF1D1E30);
  static const appBar = Color(0xffb00b69);
  static const actionButton = Color(0xff69b00b);
  static const labelText = Color(0xFF8D8E98);
}

const String fontFamily = 'Roboto';

abstract class UITextStyles {
  static const index = TextStyle(
    fontFamily: fontFamily,
    fontSize: 80,
  );
  static const label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    color: UIColors.labelText,
  );
  static const number = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w900,
    fontSize: 50,
  );

  static const roundButton = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
}
