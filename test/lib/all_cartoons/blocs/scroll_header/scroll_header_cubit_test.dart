import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';

void main() {
  group('ScrollHeaderCubit', () {
    test('initial state is false', () {
      expect(ScrollHeaderCubit().state, equals(false));
    });

    blocTest<ScrollHeaderCubit, bool>(
      'emits [true] when onScrollAfterHeader is invoked',
      build: () => ScrollHeaderCubit(),
      act: (cubit) => cubit.onScrollPastHeader(),
      expect: () => [true],
    );

    blocTest<ScrollHeaderCubit, bool>(
      'emits [false] when onScrollBeforeHeader is invoked',
      build: () => ScrollHeaderCubit(),
      seed: () => true,
      act: (cubit) => cubit.onScrollBeforeHeader(),
      expect: () => [false],
    );

    blocTest<ScrollHeaderCubit, bool>(
      'emits [false, true, false] when scroll before and after the header',
      build: () => ScrollHeaderCubit(),
      seed: () => true,
      act: (cubit) => cubit
        ..onScrollBeforeHeader()
        ..onScrollPastHeader()
        ..onScrollBeforeHeader(),
      expect: () => [false, true, false],
    );
  });
}
