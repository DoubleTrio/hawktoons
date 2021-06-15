// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';

void main() {
  group('CreateCartoonSheetState', () {
    test('supports value comparisons', () {
      expect(
        CreateCartoonSheetState.initial(),
        CreateCartoonSheetState.initial(),
      );
      expect(
        CreateCartoonSheetState.initial().toString(),
        CreateCartoonSheetState.initial().toString(),
      );
      expect(
        CreateCartoonSheetState.initial().copyWith(),
        CreateCartoonSheetState.initial(),
      );
    });
  });
}
