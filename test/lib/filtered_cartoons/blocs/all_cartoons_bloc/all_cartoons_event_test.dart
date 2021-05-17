import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../../mocks.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('AllCartoonsEvent', () {
    group('LoadAllCartoons', () {
      test('supports value comparisons', () {
        expect(
          LoadAllCartoons(mockFilter),
          LoadAllCartoons(mockFilter),
        );
        expect(
          LoadAllCartoons(mockFilter.copyWith(tag: Tag.tag2)),
          isNot(LoadAllCartoons(mockFilter)),
        );
      });
    });
    group('LoadMoreCartoons', () {
      test('supports value comparisons', () {
        expect(
          LoadMoreCartoons(mockFilter),
          LoadMoreCartoons(mockFilter),
        );
        expect(
          LoadMoreCartoons(mockFilter.copyWith(tag: Tag.tag1)),
          isNot(LoadMoreCartoons(mockFilter)),
        );
      });
    });
  });
}
