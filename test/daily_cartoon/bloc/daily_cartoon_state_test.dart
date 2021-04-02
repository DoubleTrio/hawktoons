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

    group('DailyCartoonLoad', () {
      final cartoon = MockPoliticalCartoon();
      test('supports value comparisons', () {
        expect(
          DailyCartoonLoad(dailyCartoon: cartoon),
          DailyCartoonLoad(dailyCartoon: cartoon),
        );
      });
    });
    group('DailyCartoonFailure', () {
      test('supports value comparisons', () {
        expect(
          DailyCartoonFailure(errorMessage: 'Error'),
          DailyCartoonFailure(errorMessage: 'Error'),
        );
      });
    });
  });
}
