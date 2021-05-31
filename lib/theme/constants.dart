import 'package:flutter/material.dart';

class ThemeConstants {
  static double sPadding = 8.0;
  static double mPadding = 12.0;
  static double lPadding = 16.0;
  static double sRadius = 10.0;
  static EdgeInsets defaultContainerPadding = const EdgeInsets.all(12.0);
  static BorderRadius sBorderRadius = BorderRadius.circular(10);
  static String font = 'SanFrancisco';
  static ButtonStyle buttonStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(16)
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
      ),
    ),
  );
  static TextTheme textTheme = const TextTheme(
    headline1: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontSize: 52,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      fontSize: 18,
      letterSpacing: 1.05,
    ),
    subtitle2: TextStyle(
      fontSize: 16,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      letterSpacing: 1.05,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      letterSpacing: 1.05,
    ),
  );
}

