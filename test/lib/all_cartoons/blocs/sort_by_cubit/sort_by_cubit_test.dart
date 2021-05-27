import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

void main() {
  group('SortByCubit', () {
    test('initial state is SortByMode.latestPosted', () {
      expect(SortByCubit().state, equals(SortByMode.latestPosted));
    });

    blocTest<SortByCubit, SortByMode>(
      'emits [SortByMode.earliestPublished] when selectSortBy is called',
      build: () => SortByCubit(),
      act: (cubit) => cubit.selectSortBy(SortByMode.earliestPublished),
      expect: () => [equals(SortByMode.earliestPublished)],
    );

    blocTest<SortByCubit, SortByMode>(
      'emits [SortByMode.latestPublished] '
      'when initialized with SortByMode.earliestPublished '
      'and selectSortBy is called',
      build: () => SortByCubit(),
      seed: () => SortByMode.earliestPublished,
      act: (cubit) => cubit.selectSortBy(SortByMode.latestPublished),
      expect: () => [equals(SortByMode.latestPublished)],
    );
  });
}
