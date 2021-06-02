import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('SettingsFlow', () {
    late CartoonViewCubit cartoonViewCubit;
    late PrimaryColorCubit primaryColorCubit;
    late SettingsScreenCubit settingsScreenCubit;
    late ThemeCubit themeCubit;

    setUpAll(() {
      registerFallbackValue<CartoonView>(CartoonView.staggered);
      registerFallbackValue<PrimaryColor>(PrimaryColor.red);
      registerFallbackValue<SettingsScreen>(SettingsScreen.main);
      registerFallbackValue<ThemeMode>(ThemeMode.light);
    });

    setUp(() {
      cartoonViewCubit = MockCartoonViewCubit();
      primaryColorCubit = MockPrimaryColorCubit();
      settingsScreenCubit = MockSettingsScreenCubit();
      themeCubit = MockThemeCubit();

      when(() => cartoonViewCubit.state).thenReturn(CartoonView.staggered);
      when(() => themeCubit.state).thenReturn(ThemeMode.light);
      when(() => primaryColorCubit.state).thenReturn(PrimaryColor.purple);
    });

    group('SettingsFlow', () {
      testWidgets('displays main setting view '
        'when state is SettingsScreen.main', (tester) async {
        when(() => settingsScreenCubit.state).thenReturn(SettingsScreen.main);

        await tester.pumpApp(
          const SettingsFlowView(),
          settingsScreenCubit: settingsScreenCubit,
        );
        expect(find.byType(SettingsView), findsOneWidget);
      });

      testWidgets('displays theme view '
        'when state is SettingsScreen.theme', (tester) async {
        when(() => settingsScreenCubit.state).thenReturn(SettingsScreen.theme);

        await tester.pumpApp(
          const SettingsFlowView(),
          cartoonViewCubit: cartoonViewCubit,
          primaryColorCubit: primaryColorCubit,
          settingsScreenCubit: settingsScreenCubit,
          themeCubit: themeCubit,
        );
        expect(find.byType(ThemeView), findsOneWidget);
      });
    });
  });
}
