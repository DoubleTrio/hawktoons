// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../../mocks.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('AllCartoonsEvent', () {
    group('LoadCartoons', () {
      test('supports value comparisons', () {
        expect(
          LoadCartoons(mockFilter),
          LoadCartoons(mockFilter),
        );
        expect(
          LoadCartoons(mockFilter.copyWith(tag: Tag.tag2)),
          isNot(LoadCartoons(mockFilter)),
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
    group('RefreshCartoons', () {
      test('supports value comparisons', () {
        expect(
          RefreshCartoons(),
          RefreshCartoons(),
        );
      });
    });
  });
}
