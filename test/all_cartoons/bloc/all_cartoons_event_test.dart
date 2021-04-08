import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/bloc/all_cartoons_event.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('AllCartoonsEvent', () {
    group('LoadAllCartoons', () {
      test('supports value comparisons', () {
        expect(
          LoadAllCartoons(),
          LoadAllCartoons(),
        );
      });
    });
    group('AllCartoonsErrored', () {
      test('supports value comparisons', () {
        expect(
          AllCartoonsErrored(errorMessage: 'Error message'),
          AllCartoonsErrored(errorMessage: 'Error message'),
        );
      });
    });

    group('AllCartoonsUpdated', () {
      test('supports value comparisons', () {
        final cartoons = [MockPoliticalCartoon(), MockPoliticalCartoon()];
        expect(
          AllCartoonsUpdated(cartoons: cartoons),
          AllCartoonsUpdated(cartoons: cartoons),
        );
      });
    });
  });
}
