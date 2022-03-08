import 'package:flutter/material.dart';

final _appColorScheme = const ColorScheme.dark().copyWith(
  background: const Color(0xFF0A0E20),
  primary: const Color(0xffb00b69),
  secondary: const Color(0xff69b00b),
  surface: const Color(0xFF1D1E30),
  surfaceVariant: const Color(0xFF4C4F5E),
  onPrimary: Colors.white,
  onSurface: const Color(0xFF8D8E98),
);
const _fontFamily = 'Roboto';
final appTheme = ThemeData.dark().copyWith(
  colorScheme: _appColorScheme,
  appBarTheme: AppBarTheme(
    color: _appColorScheme.primary,
    titleTextStyle: const TextStyle(fontFamily: _fontFamily, fontSize: 20),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: _appColorScheme.surface,
    contentTextStyle: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      color: _appColorScheme.onBackground,
    ),
  ),
  iconTheme: IconThemeData(color: _appColorScheme.onPrimary),
  backgroundColor: _appColorScheme.background,
  hintColor: _appColorScheme.onSurface,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _appColorScheme.secondary,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: _appColorScheme.surface,
    titleTextStyle: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
    ),
    contentTextStyle: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
    ),
  ),
  textTheme: TextTheme(
    // 1- and 2-digit index number
    displayLarge: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 64,
    ),
    // 3-digit index number
    displayMedium: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 38,
      fontWeight: FontWeight.w900,
    ),
    // Counter label
    labelMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      color: _appColorScheme.onSurface,
    ),
    // Counter value
    headlineLarge: const TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w900,
      fontSize: 40,
    ),
    // AppBar title, dialog title
    titleSmall: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
    ),
    // Dialog text, hint text
    bodyMedium: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
    ),
    // Dialog button
    bodySmall: const TextStyle(
      fontFamily: _fontFamily,
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
