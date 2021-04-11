import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/bloc/all_cartoons_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('AllCartoonsState', () {
    group('DailyCartoonInProgress', () {
      test('supports value comparisons', () {
        expect(AllCartoonsLoading(), AllCartoonsLoading());
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
    group('AllCartoonsFailed', () {
      test('supports value comparisons', () {
        expect(
          AllCartoonsFailed('Error message'),
          AllCartoonsFailed('Error message'),
        );
      });
    });
  });
}
