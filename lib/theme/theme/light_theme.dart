import 'package:flutter/material.dart';

const lightPrimary = Color(4284612846);
final lightColorScheme = const ColorScheme.light().copyWith(
  primary: lightPrimary,
  primaryVariant: lightPrimary.withOpacity(0.8),
  secondary: Colors.yellow,
  secondaryVariant: Colors.yellow.withOpacity(0.8),
  onBackground: Colors.black38,
);

var lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
    fontFamily: 'SanFrancisco',
    primaryColor: lightPrimary,
    dividerColor: Colors.grey.shade200,
    highlightColor: lightPrimary.withOpacity(0.2),
    splashColor: lightPrimary.withOpacity(0.1),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ))),
    ),
    snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(fontWeight: FontWeight.bold)),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightPrimary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightColorScheme.background,
        selectedItemColor: lightColorScheme.secondary,
        selectedLabelStyle: TextStyle(color: lightColorScheme.onSurface),
        unselectedLabelStyle: TextStyle(color: lightColorScheme.onSurface),
        unselectedItemColor: lightColorScheme.onSecondary),
    textTheme: const TextTheme(
      subtitle1: TextStyle(
        fontSize: 16,
      ),
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: lightPrimary));
