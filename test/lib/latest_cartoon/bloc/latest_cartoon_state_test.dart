// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/latest_cartoon/bloc/latest_cartoon.dart';

import '../../mocks.dart';

void main() {
  group('LatestCartoonState', () {
    group('DailyCartoonInProgress', () {
      test('supports value comparisons', () {
        expect(DailyCartoonInProgress(), DailyCartoonInProgress());
        expect(
          DailyCartoonInProgress().toString(),
          DailyCartoonInProgress().toString(),
        );
      });
    });

    group('DailyCartoonLoaded', () {
      final cartoon = MockPoliticalCartoon();
      test('supports value comparisons', () {
        expect(
          DailyCartoonLoaded(cartoon),
          DailyCartoonLoaded(cartoon),
        );
        expect(
          DailyCartoonLoaded(cartoon).toString(),
          DailyCartoonLoaded(cartoon).toString(),
        );
      });
    });

    group('DailyCartoonFailed', () {
      final errorMessage = 'Error message';
      test('supports value comparisons', () {
        expect(
          DailyCartoonFailed(errorMessage),
          DailyCartoonFailed(errorMessage),
        );
        expect(
          DailyCartoonFailed(errorMessage).toString(),
          DailyCartoonFailed(errorMessage).toString(),
        );
      });
    });
  });
}
