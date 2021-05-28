import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';

void main() {
  group('AppDrawerCubit', () {
    test('initial state is false', () {
      expect(AppDrawerCubit().state, equals(false));
    });

    blocTest<AppDrawerCubit, bool>(
      'emits [true] when drawer is open',
      build: () => AppDrawerCubit(),
      act: (cubit) => cubit.openDrawer(),
      expect: () => [true],
    );

    blocTest<AppDrawerCubit, bool>(
      'emits [false] when drawer is closed',
      build: () => AppDrawerCubit(),
      act: (cubit) => cubit.closeDrawer(),
      expect: () => [false],
    );
  });
}
