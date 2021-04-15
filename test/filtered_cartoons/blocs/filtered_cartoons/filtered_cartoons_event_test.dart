import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/filtered_cartoons/blocs/filtered_cartoons_bloc/filtered_cartoons_event.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('FilteredCartoonsEvent', () {
    group('UpdateFilter', () {
      test('supports value comparisons', () {
        expect(
          UpdateFilter(Unit.unit1),
          UpdateFilter(Unit.unit1),
        );
      });
    });
    group('UpdateFilteredCartoons', () {
      test('supports value comparisons', () {
        var cartoons = [MockPoliticalCartoon()];
        expect(
          UpdateFilteredCartoons(cartoons),
          UpdateFilteredCartoons(cartoons),
        );
      });
    });
  });
}
