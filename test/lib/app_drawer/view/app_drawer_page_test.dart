import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:hawktoons/theme/cubit/theme_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  late AllCartoonsBloc allCartoonsBloc;
  late AuthenticationBloc authenticationBloc;
  late DailyCartoonBloc dailyCartoonBloc;
  late ThemeCubit themeCubit;

  setUpAll(() {
    registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
    registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
    registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
    registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
    registerFallbackValue<ThemeMode>(ThemeMode.light);
  });

  setUp(() {
    allCartoonsBloc = MockAllCartoonsBloc();
    authenticationBloc = MockAuthenticationBloc();
    dailyCartoonBloc = MockDailyCartoonBloc();
    themeCubit = MockThemeCubit();

    when(() => themeCubit.state).thenReturn(ThemeMode.light);

  });

  group('AppDrawerPage', () {
    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const AppDrawerPage(),
          themeCubit: themeCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const AppDrawerPage(),
          mode: ThemeMode.dark,
          themeCubit: themeCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('logouts when logout list tile is tapped', (tester) async {
      await tester.pumpApp(
        const AppDrawerPage(),
        allCartoonsBloc: allCartoonsBloc,
        authenticationBloc: authenticationBloc,
        dailyCartoonBloc: dailyCartoonBloc,
        themeCubit: themeCubit,
      );
      await tester.tap(find.byKey(appDrawerLogoutTileKey));
      verify(allCartoonsBloc.close).called(1);
      verify(() => authenticationBloc.add(const Logout())).called(1);
      verify(dailyCartoonBloc.close).called(1);      
    });

    testWidgets('opens privacy info page privacy '
      'list tile is tapped', (tester) async {
      await tester.pumpApp(
        const AppDrawerPage(),
        themeCubit: themeCubit,
      );
      await tester.tap(find.byKey(appDrawerPrivacyTileKey));
    });

    testWidgets('changes theme when list tile theme is tapped', (tester) async {
      await tester.pumpApp(
        const AppDrawerPage(),
        themeCubit: themeCubit,
      );
      await tester.tap(find.byKey(appDrawerChangeThemeTileKey));
      verify(themeCubit.changeTheme).called(1);
    });
  });
}
