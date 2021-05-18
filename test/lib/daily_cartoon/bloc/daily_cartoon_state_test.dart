import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

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
