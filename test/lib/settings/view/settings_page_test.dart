import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('SettingsPage', () {
    late SettingsScreenCubit settingsScreenCubit;

    setUpAll(() {
      registerFallbackValue<SettingsScreen>(SettingsScreen.main);
    });

    setUp(() {
      settingsScreenCubit = MockSettingsScreenCubit();
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const SettingsView(),
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const SettingsView(),
          mode: ThemeMode.dark,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('sets screen to theme view', (tester) async {
      await tester.pumpApp(
        const SettingsView(),
        settingsScreenCubit: settingsScreenCubit,
      );
      await tester.tap(find.byKey(navigateToThemePageButtonKey));
      verify(
        () => settingsScreenCubit.setScreen(SettingsScreen.theme)
      ).called(1);
    });
  });
}
