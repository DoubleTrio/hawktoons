import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';

void main() {
  group('ShowBottomSheetCubit', () {
    test('initial state is false', () {
      expect(ShowBottomSheetCubit().state, equals(false));
    });

    blocTest<ShowBottomSheetCubit, bool>(
      'emits [true] when openSheet is invoked',
      build: () => ShowBottomSheetCubit(),
      act: (cubit) => cubit.openSheet(),
      expect: () => [true],
    );

    blocTest<ShowBottomSheetCubit, bool>(
      'emits [false] when closeSheet is invoked',
      build: () => ShowBottomSheetCubit(),
      seed: () => true,
      act: (cubit) => cubit.closeSheet(),
      expect: () => [false],
    );

    blocTest<ShowBottomSheetCubit, bool>(
      'emits [false, true, false] when closing and opening bottom sheet',
      build: () => ShowBottomSheetCubit(),
      seed: () => true,
      act: (cubit) => cubit..closeSheet()..openSheet()..closeSheet(),
      expect: () => [false, true, false],
    );
  });
}
