import 'package:flutter/material.dart';
import 'package:hawktoons/theme/theme.dart';

const darkPrimary = Color(0xFFDEA7FF);

final darkColorScheme = const ColorScheme.dark().copyWith(
  primary: darkPrimary,
  primaryVariant: darkPrimary.withOpacity(0.8),
  secondary: Colors.yellow,
  secondaryVariant: Colors.yellow.withOpacity(0.8),
  onBackground: Colors.white60,
);

final darkTheme = ThemeData(
  primaryColor: darkPrimary,
  brightness: Brightness.dark,
  fontFamily: ThemeConstants.font,
  dividerColor: Colors.grey.shade900,
  backgroundColor: const Color(0xFF2B2B2B),
  colorScheme: darkColorScheme,
  highlightColor: darkPrimary.withOpacity(0.2),
  splashColor: darkPrimary.withOpacity(0.1),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(darkPrimary.withOpacity(0.2)),
    thumbColor: MaterialStateProperty.all<Color>(darkPrimary.withOpacity(1)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ThemeConstants.buttonStyle,
  ),
  snackBarTheme: const SnackBarThemeData(
    contentTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF3C3C3C),
    brightness: Brightness.dark,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFF3C3C3C),
    selectedLabelStyle: TextStyle(color: darkColorScheme.onSurface),
    unselectedLabelStyle: TextStyle(color: darkColorScheme.onSurface),
    unselectedItemColor: darkColorScheme.onSecondary
  ),
  textTheme: ThemeConstants.textTheme,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: darkPrimary
  )
);
