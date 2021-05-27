// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/daily_cartoon/bloc/daily_cartoon.dart';

import '../../mocks.dart';

void main() {
  group('DailyCartoonEvent', () {
    group('LoadDailyCartoon', () {
      test('supports value comparisons', () {
        expect(
          LoadDailyCartoon(),
          LoadDailyCartoon(),
        );
        expect(
          LoadDailyCartoon().toString(),
          LoadDailyCartoon().toString(),
        );
      });
    });
    group('ErrorDailyCartoonEvent', () {
      final errorMessage = 'Error message';
      test('supports value comparisons', () {
        expect(
          ErrorDailyCartoonEvent(errorMessage),
          ErrorDailyCartoonEvent(errorMessage),
        );
        expect(
          ErrorDailyCartoonEvent(errorMessage).toString(),
          ErrorDailyCartoonEvent(errorMessage).toString(),
        );
      });
    });

    group('UpdateDailyCartoon', () {
      test('supports value comparisons', () {
        final cartoon = MockPoliticalCartoon();
        expect(
          UpdateDailyCartoon(cartoon),
          UpdateDailyCartoon(cartoon),
        );
        expect(
          UpdateDailyCartoon(cartoon).toString(),
          UpdateDailyCartoon(cartoon).toString(),
        );
      });
    });
  });
}
