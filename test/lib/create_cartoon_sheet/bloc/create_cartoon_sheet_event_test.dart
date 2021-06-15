// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';

void main() {
  group('CreateCartoonSheetEvent', () {
    group('UpdateFile', () {
      test('supports value comparisons', () {
        expect(
          UpdateFile(),
          UpdateFile(),
        );
        expect(
          UpdateFile().toString(),
          UpdateFile().toString(),
        );
      });
    });
  });
}
