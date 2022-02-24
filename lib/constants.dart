import 'package:flutter/material.dart';

abstract class UIColors {
  static const tile = Color(0xFF1D1E30);
  static const appBar = Color(0xffb00b69);
  static const actionButton = Color(0xff69b00b);
}

abstract class UITextStyles {
  static const label = TextStyle(
    fontSize: 18,
    color: Color(0xFF8D8E98),
  );
  static const number = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w900,
  );
  static const index = TextStyle(
    fontSize: 80,
  );
}
