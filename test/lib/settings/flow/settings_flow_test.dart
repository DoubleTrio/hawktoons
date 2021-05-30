import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('SettingsFlow', () {
    late SettingsScreenCubit settingsScreenCubit;

    setUpAll(() {
      registerFallbackValue<SettingsScreen>(SettingsScreen.main);
    });

    setUp(() {
      settingsScreenCubit = MockSettingsScreenCubit();
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
          settingsScreenCubit: settingsScreenCubit,
        );

        expect(find.byType(ThemeView), findsOneWidget);
      });
    });
  });
}
