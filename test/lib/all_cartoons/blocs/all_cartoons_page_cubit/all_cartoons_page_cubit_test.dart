import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';

import '../../../mocks.dart';

void main() {
  final mockCartoon = MockPoliticalCartoon();
  final initialState = const AllCartoonsPageState.initial();

  group('AllCartoonsPageCubit', () {
    test('initial state is AllCartoonsPageCubit.initial', () {
      expect(
        AllCartoonsPageCubit().state,
        initialState,
      );
    });

    blocTest<AllCartoonsPageCubit, AllCartoonsPageState>(
      'emits correct scroll states'
      'when onScrollPastHeader and onScrollBeforeHeader is invoked',
      build: () => AllCartoonsPageCubit(),
      act: (cubit) => cubit..onScrollPastHeader()..onScrollBeforeHeader(),
      expect: () => [
        initialState.copyWith(isScrolledPastHeader: true),
        initialState.copyWith(isScrolledPastHeader: false)
      ],
    );

    blocTest<AllCartoonsPageCubit, AllCartoonsPageState>(
      'emits correct show filter sheet states'
      'when openFilterSheet and closeFilterSheet is invoked',
      build: () => AllCartoonsPageCubit(),
      act: (cubit) => cubit..openFilterSheet()..closeFilterSheet(),
      expect: () => [
        initialState.copyWith(shouldShowFilterSheet: true),
        initialState.copyWith(shouldShowFilterSheet: false),
      ],
    );

    blocTest<AllCartoonsPageCubit, AllCartoonsPageState>(
      'emits correct show create cartoon sheet states'
      'when openCreateCartoonSheet and closeCreateCartoonSheet is invoked',
      build: () => AllCartoonsPageCubit(),
      act: (cubit) => cubit
        ..openCreateCartoonSheet()
        ..closeCreateCartoonSheet(),
      expect: () => [
        initialState.copyWith(shouldShowCreateCartoonSheet: true),
        initialState.copyWith(shouldShowCreateCartoonSheet: false),
      ],
    );

    blocTest<AllCartoonsPageCubit, AllCartoonsPageState>(
      'emits correct select cartoon states'
      'when selectCartoon and deselectCartoon is invoked',
      build: () => AllCartoonsPageCubit(),
      act: (cubit) => cubit
        ..selectCartoon(mockCartoon)
        ..deselectCartoon(),
      expect: () => [
        initialState.copyWith(politicalCartoon: SelectPoliticalCartoonState(
          cartoon: mockCartoon
        )),
        initialState.copyWith(
          politicalCartoon: const SelectPoliticalCartoonState()
        ),
      ],
    );
  });
}