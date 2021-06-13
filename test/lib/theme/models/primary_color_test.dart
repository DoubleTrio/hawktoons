import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/appearances/appearances.dart';

void main() {
  group('PrimaryColor', () {
    test('gets the light color', () {
      expect(PrimaryColor.red.lightColor, const Color(0xFFFF3636));
    });

    test('gets the dark color', () {
      expect(PrimaryColor.red.darkColor, const Color(0xFFFFA7A7));
    });
  });
}