// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';

import '../../mocks.dart';

void main() {
  group('DailyCartoonEvent', () {
    group('LoadDailyCartoon', () {
      test('supports value comparisons', () {
        expect(
          LoadDailyCartoon(),
          LoadDailyCartoon(),
        );
      });
    });
    group('ErrorDailyCartoonEvent', () {
      test('supports value comparisons', () {
        expect(
          ErrorDailyCartoonEvent('Error message'),
          ErrorDailyCartoonEvent('Error message'),
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
      });
    });
  });
}
