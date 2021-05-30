import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/settings/settings.dart';

void main() {
  group('SettingsScreenCubit', () {
    test('initial state is SettingsScreen.main', () {
      expect(
        SettingsScreenCubit().state,
        equals(SettingsScreen.main),
      );
    });

    blocTest<SettingsScreenCubit, SettingsScreen>(
      'emits [SettingsScreen.theme] when setScreen is invoked',
      build: () => SettingsScreenCubit(),
      act: (cubit) =>
        cubit.setScreen(SettingsScreen.theme),
      expect: () => [SettingsScreen.theme],
    );

    blocTest<SettingsScreenCubit, SettingsScreen>(
      'emits [SettingsScreen.main] when deselect screen is invoked',
      build: () => SettingsScreenCubit(),
      act: (cubit) => cubit.deselectScreen(),
      expect: () => [SettingsScreen.main],
    );

    blocTest<SettingsScreenCubit, SettingsScreen>(
      'emits correct screens when setScreen is invoked 3 times',
      build: () => SettingsScreenCubit(),
      act: (cubit) => cubit
        ..setScreen(SettingsScreen.theme)
        ..setScreen(SettingsScreen.main)
        ..setScreen(SettingsScreen.theme),
      expect: () => [
        SettingsScreen.theme,
        SettingsScreen.main,
        SettingsScreen.theme,
      ],
    );
  });
}
