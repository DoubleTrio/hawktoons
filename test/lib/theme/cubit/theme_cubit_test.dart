import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('ThemeCubit', () {
    setUpAll(initHydratedBloc);

    test('fromJson and toJson works', () {
      expect(
        ThemeCubit().fromJson(ThemeCubit().toJson(ThemeMode.light)),
        ThemeMode.light
      );
    });

    blocTest<ThemeCubit, ThemeMode>(
      'emits [ThemeMode.dark] when changeTheme is called',
      seed: () => ThemeMode.light,
      build: () => ThemeCubit(),
      act: (cubit) => cubit.changeTheme(),
      expect: () => [ThemeMode.dark],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'emits [ThemeMode.light] when initialized with '
      'ThemeMode.dark and changeTheme is called',
      build: () => ThemeCubit(),
      seed: () => ThemeMode.dark,
      act: (cubit) => cubit.changeTheme(),
      expect: () => [ThemeMode.light],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'emits [ThemeMode.light, ThemeMode.dark] when initialized with '
      'ThemeMode.dark and changeTheme is called twice',
      build: () => ThemeCubit(),
      seed: () => ThemeMode.dark,
      act: (cubit) => cubit..changeTheme()..changeTheme(),
      expect: () => [ThemeMode.light, ThemeMode.dark],
    );
  });
}
