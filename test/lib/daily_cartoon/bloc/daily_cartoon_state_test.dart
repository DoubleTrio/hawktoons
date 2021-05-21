// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';

import '../../mocks.dart';

void main() {
  group('DailyCartoonState', () {
    group('DailyCartoonInProgress', () {
      test('supports value comparisons', () {
        expect(DailyCartoonInProgress(), DailyCartoonInProgress());
      });
    });
    group('DailyCartoonLoaded', () {
      final cartoon = MockPoliticalCartoon();
      test('supports value comparisons', () {
        expect(
          DailyCartoonLoaded(cartoon),
          DailyCartoonLoaded(cartoon),
        );
      });
    });
    group('DailyCartoonFailed', () {
      test('supports value comparisons', () {
        expect(
          DailyCartoonFailed('Error message'),
          DailyCartoonFailed('Error message'),
        );
      });
    });
  });
}
