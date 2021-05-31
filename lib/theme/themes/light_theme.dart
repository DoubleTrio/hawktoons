import 'package:flutter/material.dart';
import 'package:hawktoons/theme/constants.dart';
import 'themes.dart';

const lightPrimary = Color(4284612846);

final lightColorScheme = const ColorScheme.light().copyWith(
  primary: lightPrimary,
  primaryVariant: lightPrimary.withOpacity(0.8),
  secondary: Colors.yellow,
  secondaryVariant: Colors.yellow.withOpacity(0.8),
  onBackground: Colors.black38,
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  fontFamily: ThemeConstants.font,
  primaryColor: lightPrimary,
  dividerColor: Colors.grey.shade300,
  backgroundColor: Colors.grey.shade100,
  highlightColor: lightPrimary.withOpacity(0.2),
  splashColor: lightPrimary.withOpacity(0.1),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(lightPrimary.withOpacity(0.2)),
    thumbColor: MaterialStateProperty.all<Color>(lightPrimary.withOpacity(0.5)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ThemeConstants.buttonStyle,
  ),
  snackBarTheme: const SnackBarThemeData(
    contentTextStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: lightPrimary,
    brightness: Brightness.dark,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightColorScheme.background,
    selectedItemColor: lightColorScheme.secondary,
    selectedLabelStyle: TextStyle(color: lightColorScheme.onSurface),
    unselectedLabelStyle: TextStyle(color: lightColorScheme.onSurface),
    unselectedItemColor: lightColorScheme.onSecondary
  ),
  textTheme: ThemeConstants.textTheme,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: lightPrimary
  )
);
