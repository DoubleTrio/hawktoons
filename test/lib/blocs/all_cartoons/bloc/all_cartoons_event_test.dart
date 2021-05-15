import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/all_cartoons/bloc/all_cartoons_event.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('AllCartoonsEvent', () {
    group('LoadAllCartoons', () {
      test('supports value comparisons', () {
        expect(
          LoadAllCartoons(SortByMode.latestPosted, ImageType.all, Tag.all),
          LoadAllCartoons(SortByMode.latestPosted, ImageType.all, Tag.all),
        );
      });
    });
    group('LoadMoreCartoons', () {
      test('supports value comparisons', () {
        expect(
          LoadMoreCartoons(SortByMode.latestPublished, ImageType.all, Tag.all),
          LoadMoreCartoons(SortByMode.latestPublished, ImageType.all, Tag.all),
        );
      });
    });
    group('ErrorAllCartoonsEvent', () {
      test('supports value comparisons', () {
        expect(
          ErrorAllCartoonsEvent('Error message'),
          ErrorAllCartoonsEvent('Error message'),
        );
      });
    });
    group('UpdateAllCartoons', () {
      test('supports value comparisons', () {
        final cartoons = [MockPoliticalCartoon(), MockPoliticalCartoon()];
        expect(
          UpdateAllCartoons(cartoons: cartoons),
          UpdateAllCartoons(cartoons: cartoons),
        );
      });
    });
  });
}
