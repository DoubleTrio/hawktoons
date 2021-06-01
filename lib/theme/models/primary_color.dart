import 'package:flutter/material.dart';

enum PrimaryColor {
  purple,
  red,
  orange,
  yellow,
  green,
  blue,
  pink,
  navy,
}

extension PrimaryColors on PrimaryColor {
  static const colorNames = {
    PrimaryColor.purple: 'Purple',
    PrimaryColor.red: 'Red',
    PrimaryColor.yellow: 'Yellow',
    PrimaryColor.orange: 'Orange',
    PrimaryColor.green: 'Green',
    PrimaryColor.blue: 'Blue',
    PrimaryColor.pink: 'Pink',
    PrimaryColor.navy: 'Navy',
  };

  static const lightColors = {
    PrimaryColor.purple: Color(4284612846),
    PrimaryColor.red: Color(0xFFFF3636),
    PrimaryColor.orange: Color(0xFFFFB963),
    PrimaryColor.yellow: Color(0xFFFFEA63),
    PrimaryColor.green: Color(0xFFA3E56D),
    PrimaryColor.blue: Colors.blue,
    PrimaryColor.pink: Color(0xFFFF63B3),
    PrimaryColor.navy: Color(0xFF000080),
  };

  static const darkColors = {
    PrimaryColor.purple: Color(0xFFDEA7FF),
    PrimaryColor.red: Color(0xFFFFA7A7),
    PrimaryColor.orange: Color(0xFFFFC3A7),
    PrimaryColor.yellow: Color(0xFFFFE9A7),
    PrimaryColor.green: Color(0xFFADFFA7),
    PrimaryColor.blue: Color(0xFFA7B0FF),
    PrimaryColor.pink: Color(0xFFFFA2CA),
    PrimaryColor.navy: Color(0xFF7A7AFF),
  };

  Color? get lightColor => lightColors[this];
  Color? get darkColor => darkColors[this];
  String? get colorName => colorNames[this];
}