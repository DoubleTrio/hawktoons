// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../../mocks.dart';

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
        expect(
          LoadCartoons(mockFilter).toString(),
          LoadCartoons(mockFilter).toString(),
        );
      });
    });

    group('LoadMoreCartoons', () {
      test('supports value comparisons', () {
        expect(
          LoadMoreCartoons(),
          LoadMoreCartoons(),
        );
        expect(
          LoadMoreCartoons().toString(),
          LoadMoreCartoons().toString(),
        );
      });
    });

    group('RefreshCartoons', () {
      test('supports value comparisons', () {
        expect(
          RefreshCartoons(),
          RefreshCartoons(),
        );
        expect(
          RefreshCartoons().toString(),
          RefreshCartoons().toString(),
        );
      });
    });

    group('UpdateCartoonView', () {
      test('supports value comparisons', () {
        expect(
          UpdateCartoonView(CartoonView.staggered),
          UpdateCartoonView(CartoonView.staggered),
        );
        expect(
          UpdateCartoonView(CartoonView.staggered).toString(),
          UpdateCartoonView(CartoonView.staggered).toString(),
        );
      });
    });
  });
}
