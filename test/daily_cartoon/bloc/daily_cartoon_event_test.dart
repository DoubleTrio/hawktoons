import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

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
    group('DailyCartoonErrored', () {
      test('supports value comparisons', () {
        expect(
          DailyCartoonErrored('Error message'),
          DailyCartoonErrored('Error message'),
        );
      });
    });

    group('UpdateDailyCartoon', () {
      test('supports value comparisons', () {
        final cartoon = MockPoliticalCartoon();
        expect(
          UpdateDailyCartoon(cartoon: cartoon),
          UpdateDailyCartoon(cartoon: cartoon),
        );
      });
    });
  });
}
