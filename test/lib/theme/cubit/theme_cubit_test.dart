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
      'emits [ThemeMode.dark] when setTheme is invoked',
      build: () => ThemeCubit(),
      act: (cubit) => cubit.setTheme(ThemeMode.dark),
      expect: () => [ThemeMode.dark],
    );


    blocTest<ThemeCubit, ThemeMode>(
      'emits corrects themes when setTheme is invoked twice',
      build: () => ThemeCubit(),
      seed: () => ThemeMode.dark,
      act: (cubit) => cubit
        ..setTheme(ThemeMode.system)
        ..setTheme(ThemeMode.light)
        ..setTheme(ThemeMode.dark),
      expect: () => [ThemeMode.system, ThemeMode.light, ThemeMode.dark],
    );
  });
}
