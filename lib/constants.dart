import 'package:flutter/material.dart';

///The colors used in the app UI.
abstract class UIColors {
  static const appBar = Color(0xffb00b69);
  static const actionButton = Color(0xff69b00b);
  static const appBackground = Color(0xFF0A0E20);
  static const counterTile = Color(0xFF1D1E30);
  static const labelText = Color(0xFF8D8E98);
  static const roundButton = Color(0xFF4C4F5E);
}

final colorScheme = const ColorScheme.dark().copyWith(
  background: const Color(0xFF0A0E20),
  primary: const Color(0xffb00b69),
  secondary: const Color(0xff69b00b),
);

final appTheme = ThemeData.dark().copyWith(
  primaryColor: UIColors.appBackground,
  scaffoldBackgroundColor: UIColors.appBackground,
  //colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pink),
  appBarTheme: const AppBarTheme(
    color: UIColors.appBar,
    titleTextStyle: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: UIColors.actionButton,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: UIColors.counterTile,
    titleTextStyle: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
    ),
    contentTextStyle: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
    ),
  ),
  textTheme: const TextTheme(
    // 1- and 2-digit index number
    displayLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 64,
    ),
    // 3-digit index number
    displayMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 38,
      fontWeight: FontWeight.w900,
    ),
    // Counter label
    labelMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      color: UIColors.labelText,
    ),
    // Counter value
    headlineLarge: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w900,
      fontSize: 40,
    ),
    // AppBar title, dialog title
    titleSmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
    ),
    // Dialog text, hint text
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
    ),
    // Dialog button
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
    ),
  ),
);

///The text strings used in the app.
///
///Internationalization is planned, but for now it's all in pt-br.
abstract class UITextStrings {
  static const String appName = 'Conta Ponto';
  static const String counterLabel = 'PONTO';
  static const String dialogTitleDeleteAll = 'Apagar tudo';
  static const String dialogContentDeleteAll =
      'Você tem certeza de que deseja apagar todas as camadas?';
  static const String dialogTitleSetCounter = 'Alterar valor';
  static const String dialogButtonYes = 'Sim';
  static const String dialogButtonNo = 'Não';
  static const String dialogButtonOK = 'OK';
  static const String dialogButtonCancel = 'Cancelar';
  static const String emptyListSnackBar = 'A lista já está vazia!';
  static const String dialogTitleAddMultiple = 'Adicionar várias camadas';
  static const String addMultipleHintText = '1';
}
