import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('ThemePage', () {
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

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const ThemeView(),
          cartoonViewCubit: cartoonViewCubit,
          primaryColorCubit: primaryColorCubit,
          themeCubit: themeCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const ThemeView(),
          mode: ThemeMode.dark,
          cartoonViewCubit: cartoonViewCubit,
          primaryColorCubit: primaryColorCubit,
          themeCubit: themeCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('can navigate back to main settings page', (tester) async {
      await tester.pumpApp(
        const ThemeView(),
        cartoonViewCubit: cartoonViewCubit,
        primaryColorCubit: primaryColorCubit,
        settingsScreenCubit: settingsScreenCubit,
        themeCubit: themeCubit,
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
          primaryColorCubit: primaryColorCubit,
          themeCubit: themeCubit,
        );
        await tester.tap(find.byKey(primaryColorItemKey));
        verify(() => primaryColorCubit.setColor(PrimaryColor.orange)).called(1);
      });

      testWidgets('renders light mode in color picker', (tester) async {
        await tester.pumpApp(
          const PrimaryColorPicker(),
          primaryColorCubit: primaryColorCubit,
          themeCubit: themeCubit,
        );

        final widget = tester.firstWidget(
          find.byKey(primaryColorItemKey)
        ) as PrimaryColorItem;
        expect(widget.color, const Color(0xFFFFB963));
      });

      testWidgets('renders dark mode color in color picker', (tester) async {
        when(() => themeCubit.state).thenReturn(ThemeMode.dark);
        await tester.pumpApp(
          const PrimaryColorPicker(),
          primaryColorCubit: primaryColorCubit,
          themeCubit: themeCubit,
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
          themeCubit: themeCubit,
        );
        await tester.tap(find.byKey(themeModeTileKey));
        verify(() => themeCubit.setTheme(themeMode)).called(1);
      });
    });

    group('CartoonViewPicker', () {
      const cartoonView = CartoonView.card;
      final cartoonViewTileKey = Key('CartoonViewTile_${cartoonView.index}');
      testWidgets('can change theme mode '
        'when dark mode tile is tapped', (tester) async {
        await tester.pumpApp(
          const CartoonViewPicker(),
          cartoonViewCubit: cartoonViewCubit,
        );
        await tester.tap(find.byKey(cartoonViewTileKey));
        verify(() => cartoonViewCubit.setCartoonView(cartoonView)).called(1);
      });
    });
  });
}