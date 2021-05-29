import 'package:flutter/material.dart';

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
  fontFamily: 'SanFrancisco',
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
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(16)
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
      ),
    ),
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
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      fontSize: 16,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: lightPrimary
  )
);
