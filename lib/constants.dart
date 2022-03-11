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
    titleTextStyle: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      color: _appColorScheme.onPrimary,
    ),
    iconTheme: IconThemeData(color: _appColorScheme.onPrimary),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: _appColorScheme.surface,
    contentTextStyle: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      color: _appColorScheme.onBackground,
    ),
  ),
  backgroundColor: _appColorScheme.background,
  hintColor: _appColorScheme.onSurface,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _appColorScheme.secondary,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: _appColorScheme.surface,
    titleTextStyle: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      color: _appColorScheme.onPrimary,
    ),
    contentTextStyle: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      color: _appColorScheme.onPrimary,
    ),
  ),
  textTheme: TextTheme(
    // 1- and 2-digit index number
    displayLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 64,
      color: _appColorScheme.onPrimary,
    ),
    // 3-digit index number
    displayMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 38,
      fontWeight: FontWeight.w900,
      color: _appColorScheme.onPrimary,
    ),
    // Counter label
    labelMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      color: _appColorScheme.onSurface,
    ),
    // Counter value
    headlineLarge: TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w900,
      color: _appColorScheme.onPrimary,
      fontSize: 40,
    ),
    // AppBar title, dialog title
    titleSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      color: _appColorScheme.onPrimary,
    ),
    // Dialog text, hint text
    bodyMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      color: _appColorScheme.onPrimary,
    ),
    // Dialog button
    bodySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      color: _appColorScheme.onPrimary,
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
  static const String actionButtonTooltip =
      'Adicionar nova camada\nSegure para adicionar várias';
}
