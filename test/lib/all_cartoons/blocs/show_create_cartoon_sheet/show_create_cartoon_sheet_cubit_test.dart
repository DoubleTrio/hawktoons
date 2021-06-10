import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';

void main() {
  group('ShowCreateCartoonSheetCubit', () {
    test('initial state is false', () {
      expect(ShowFilterBottomSheetCubit().state, equals(false));
    });

    blocTest<ShowCreateCartoonSheetCubit, bool>(
      'emits [true] when openSheet is invoked',
      build: () => ShowCreateCartoonSheetCubit(),
      act: (cubit) => cubit.openSheet(),
      expect: () => [true],
    );

    blocTest<ShowCreateCartoonSheetCubit, bool>(
      'emits [false] when closeSheet is invoked',
      build: () => ShowCreateCartoonSheetCubit(),
      seed: () => true,
      act: (cubit) => cubit.closeSheet(),
      expect: () => [false],
    );

    blocTest<ShowCreateCartoonSheetCubit, bool>(
      'emits [false, true, false] when closing and opening bottom sheet',
      build: () => ShowCreateCartoonSheetCubit(),
      seed: () => true,
      act: (cubit) => cubit
        ..closeSheet()
        ..openSheet()
        ..closeSheet(),
      expect: () => [false, true, false],
    );
  });
}
