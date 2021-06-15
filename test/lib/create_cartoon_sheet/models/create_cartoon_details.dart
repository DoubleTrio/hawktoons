// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';

void main() {
  group('CreateCartoonDetails', () {
    test('supports value comparisons', () {
      expect(
        CreateCartoonDetails(),
        CreateCartoonDetails(),
      );
      expect(
        CreateCartoonDetails().copyWith(),
        isNot(equals(
          CreateCartoonSheetState.initial().copyWith(
            page: CreateCartoonPage.author
          )
        )),
      );
    });
  });
}
