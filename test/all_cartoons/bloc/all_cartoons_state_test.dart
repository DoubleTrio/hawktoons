import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/bloc/all_cartoons_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('AllCartoonsState', () {
    group('DailyCartoonInProgress', () {
      test('supports value comparisons', () {
        expect(AllCartoonsInProgress(), AllCartoonsInProgress());
      });
    });

    group('AllCartoonsLoaded', () {
      final cartoons = [MockPoliticalCartoon(), MockPoliticalCartoon()];
      test('supports value comparisons', () {
        expect(
          AllCartoonsLoaded(cartoons: cartoons),
          AllCartoonsLoaded(cartoons: cartoons),
        );
      });
    });
    group('AllCartoonsLoadFailure', () {
      test('supports value comparisons', () {
        expect(
          AllCartoonsLoadFailure(errorMessage: 'Error message'),
          AllCartoonsLoadFailure(errorMessage: 'Error message'),
        );
      });
    });
  });
}
