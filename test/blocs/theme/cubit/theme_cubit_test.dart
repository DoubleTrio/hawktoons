import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/theme/theme.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('ThemeCubit', () {
    // setUpAll(() async {
    //   await setUpHydratedDirectory();
    // });
    //
    // test('initial state is ThemeMode.light', () {
    //   expect(ThemeCubit().state, equals(ThemeMode.light));
    // });
    //
    // blocTest<ThemeCubit, ThemeMode>(
    //   'emits [ThemeMode.dark] when changeTheme is called',
    //   build: () => ThemeCubit(),
    //   act: (cubit) => cubit.changeTheme(),
    //   expect: () => [equals(ThemeMode.dark)],
    // );
    //
    // blocTest<ThemeCubit, ThemeMode>(
    //   'emits [ThemeMode.light] when initialized with '
    //   'ThemeMode.dark and changeTheme is called',
    //   build: () => ThemeCubit(),
    //   seed: () => ThemeMode.dark,
    //   act: (cubit) => cubit.changeTheme(),
    //   expect: () => [equals(ThemeMode.light)],
    // );
  });
}
