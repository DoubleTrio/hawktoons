import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('AppearancesPage', () {
    final appearancesInitialState = const AppearancesState.initial();
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
        appearancesInitialState
      );
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const ThemeView(),
          appearancesCubit: appearancesCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const ThemeView(),
          mode: ThemeMode.dark,
          appearancesCubit: appearancesCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('can navigate back to main settings page', (tester) async {
      await tester.pumpApp(
        const ThemeView(),
        appearancesCubit: appearancesCubit,
        settingsScreenCubit: settingsScreenCubit,
      );
      await tester.tap(find.byIcon(Icons.arrow_back));
      verify(settingsScreenCubit.deselectScreen).called(1);
    });

    group('PrimaryColorPicker', () {
      const color = PrimaryColor.orange;
      final primaryColorItemKey = Key('PrimaryColorItem_${color.index}');
      testWidgets('can change color primary '
        'when PrimaryItemColor is tapped', (tester) async {
        await tester.pumpApp(
          const PrimaryColorPicker(),
          appearancesCubit: appearancesCubit,
        );
        await tester.tap(find.byKey(primaryColorItemKey));
        verify(() => appearancesCubit.setColor(PrimaryColor.orange)).called(1);
      });

      testWidgets('renders light mode in color picker', (tester) async {
        when(() => appearancesCubit.state).thenReturn(
          appearancesInitialState.copyWith(themeMode: ThemeMode.light)
        );
        await tester.pumpApp(
          const PrimaryColorPicker(),
          appearancesCubit: appearancesCubit,
        );

        await tester.pump();
        final widget = tester.firstWidget(
          find.byKey(primaryColorItemKey)
        ) as PrimaryColorItem;
        expect(widget.color, const Color(0xFFFFB963));
      });

      testWidgets('renders dark mode color in color picker', (tester) async {
        when(() => appearancesCubit.state).thenReturn(
          appearancesInitialState.copyWith(themeMode: ThemeMode.dark)
        );
        await tester.pumpApp(
          const PrimaryColorPicker(),
          appearancesCubit: appearancesCubit,
        );

        final widget = tester.firstWidget(
          find.byKey(primaryColorItemKey)
        ) as PrimaryColorItem;
        expect(widget.color, const Color(0xFFFFC3A7));
      });
    });

    group('ThemeModePicker', () {
      const themeMode = ThemeMode.dark;
      final themeModeTileKey = Key('ThemeModeTile_${themeMode.index}');
      testWidgets('can change theme mode '
          'when dark mode tile is tapped', (tester) async {
        await tester.pumpApp(
          const ThemeModePicker(),
          appearancesCubit: appearancesCubit,
        );
        await tester.tap(find.byKey(themeModeTileKey));
        verify(() => appearancesCubit.setTheme(themeMode)).called(1);
      });
    });

    group('CartoonViewPicker', () {
      const cartoonView = CartoonView.card;
      final cartoonViewTileKey = Key('CartoonViewTile_${cartoonView.index}');
      testWidgets('can change theme mode '
        'when dark mode tile is tapped', (tester) async {
        await tester.pumpApp(
          const CartoonViewPicker(),
          appearancesCubit: appearancesCubit,
        );
        await tester.tap(find.byKey(cartoonViewTileKey));
        verify(() => appearancesCubit.setCartoonView(cartoonView)).called(1);
      });
    });
  });
}