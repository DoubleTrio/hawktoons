import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('Theme{age', () {
    late SettingsScreenCubit settingsScreenCubit;
    late ThemeCubit themeCubit;

    setUpAll(() {
      registerFallbackValue<SettingsScreen>(SettingsScreen.main);
      registerFallbackValue<ThemeMode>(ThemeMode.light);
    });

    setUp(() {
      settingsScreenCubit = MockSettingsScreenCubit();
      themeCubit = MockThemeCubit();
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const ThemeView(),
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const ThemeView(),
          mode: ThemeMode.dark,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('can navigate back to main settings page', (tester) async {
      await tester.pumpApp(
        const ThemeView(),
        settingsScreenCubit: settingsScreenCubit,
      );
      await tester.tap(find.byIcon(Icons.arrow_back));
      verify(settingsScreenCubit.deselectScreen).called(1);
    });

    testWidgets('can change theme '
      'when change theme button is tapped', (tester) async {
      await tester.pumpApp(
        const ThemeView(),
        themeCubit: themeCubit,
      );
      await tester.tap(find.byKey(themePageChangeThemeButtonKey));
      verify(themeCubit.changeTheme).called(1);
    });
  });
}
