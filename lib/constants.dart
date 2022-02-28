import 'package:flutter/material.dart';

abstract class UIColors {
  static const appBar = Color(0xffb00b69);
  static const appBackground = Color(0xFF0A0E20);
  static const actionButton = Color(0xff69b00b);
  static const counterTile = Color(0xFF1D1E30);
  static const labelText = Color(0xFF8D8E98);
  static const roundButton = Color(0xFF4C4F5E);
}

final appTheme = ThemeData.dark().copyWith(
  primaryColor: UIColors.appBackground,
  scaffoldBackgroundColor: UIColors.appBackground,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pink),
);

abstract class UITextStyles {
  static const String _fontFamily = 'Roboto';

  static const appBar = TextStyle(
    fontFamily: _fontFamily,
  );
  static const indexNumber = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 64,
  );
  static const label = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    color: UIColors.labelText,
  );
  static const counterValue = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w900,
    fontSize: 50,
  );

  static const roundButton = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
  static const dialogTitle = TextStyle(
    fontFamily: _fontFamily,
  );
  static const dialogContent = TextStyle(
    fontFamily: _fontFamily,
  );
  static const dialogTextFieldHint = TextStyle(
    fontFamily: _fontFamily,
    color: UIColors.labelText,
  );
  static const dialogButton = TextStyle(
    fontFamily: _fontFamily,
    color: UIColors.actionButton,
  );
}

abstract class UITextStrings {
  static const String appBarTitle = 'Conta Ponto';
  static const String counterLabel = 'PONTO';
  static const String dialogTitleDeleteAll = 'Apagar tudo';
  static const String dialogContentDeleteAll =
      'Tem certeza de que deseja apagar todas as camadas?';
  static const String dialogTitleSetCounter = 'Modificar valor';
  static const String dialogTextFieldHint = 'Digite aqui o valor';
  static const String dialogButtonYes = 'Sim';
  static const String dialogButtonNo = 'Não';
  static const String dialogButtonOK = 'OK';
  static const String dialogButtonCancel = 'Cancelar';
}
