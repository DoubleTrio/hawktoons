import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';

void main() {
  group('ShowFilterBottomSheetCubit', () {
    test('initial state is false', () {
      expect(ShowFilterBottomSheetCubit().state, equals(false));
    });

    blocTest<ShowFilterBottomSheetCubit, bool>(
      'emits [true] when openSheet is invoked',
      build: () => ShowFilterBottomSheetCubit(),
      act: (cubit) => cubit.openSheet(),
      expect: () => [true],
    );

    blocTest<ShowFilterBottomSheetCubit, bool>(
      'emits [false] when closeSheet is invoked',
      build: () => ShowFilterBottomSheetCubit(),
      seed: () => true,
      act: (cubit) => cubit.closeSheet(),
      expect: () => [false],
    );

    blocTest<ShowFilterBottomSheetCubit, bool>(
      'emits [false, true, false] when closing and opening bottom sheet',
      build: () => ShowFilterBottomSheetCubit(),
      seed: () => true,
      act: (cubit) => cubit
        ..closeSheet()
        ..openSheet()
        ..closeSheet(),
      expect: () => [false, true, false],
    );
  });
}
