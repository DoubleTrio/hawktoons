import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('SettingsFlow', () {
    late AppearancesCubit appearancesCubit;
    late SettingsScreenCubit settingsScreenCubit;

    setUpAll(() {
      registerFallbackValue<AppearancesState>(FakeAppearancesState());
      registerFallbackValue<SettingsScreen>(SettingsScreen.main);
    });

    setUp(() {
      appearancesCubit = MockAppearancesCubit();
      settingsScreenCubit = MockSettingsScreenCubit();
      when(() => appearancesCubit.state).thenReturn(
        const AppearancesState.initial()
      );
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
          appearancesCubit: appearancesCubit,
          settingsScreenCubit: settingsScreenCubit,
        );
        expect(find.byType(ThemeView), findsOneWidget);
      });
    });
  });
}
