import 'package:flutter/material.dart';

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
  fontFamily: 'SanFrancisco',
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
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(16),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
      ),
    )
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
    selectedItemColor: darkColorScheme.secondary,
    selectedLabelStyle: TextStyle(color: darkColorScheme.onSurface),
    unselectedLabelStyle: TextStyle(color: darkColorScheme.onSurface),
    unselectedItemColor: darkColorScheme.onSecondary
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      fontSize: 16,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: darkPrimary
  )
);
