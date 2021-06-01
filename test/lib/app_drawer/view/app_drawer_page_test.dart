import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/latest_cartoon/bloc/latest_cartoon.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  late AllCartoonsBloc allCartoonsBloc;
  late AuthenticationBloc authenticationBloc;
  late LatestCartoonBloc latestCartoonBloc;
  late ThemeCubit themeCubit;

  setUpAll(() {
    registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
    registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
    registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    registerFallbackValue<LatestCartoonState>(FakeLatestCartoonState());
    registerFallbackValue<LatestCartoonEvent>(FakeLatestCartoonEvent());
    registerFallbackValue<ThemeMode>(ThemeMode.light);
  });

  setUp(() {
    allCartoonsBloc = MockAllCartoonsBloc();
    authenticationBloc = MockAuthenticationBloc();
    latestCartoonBloc = MockLatestCartoonBloc();
    themeCubit = MockThemeCubit();
    when(() => themeCubit.state).thenReturn(ThemeMode.light);
  });

  group('AppDrawerView', () {
    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const AppDrawerView(backgroundOpacity: 0),
          themeCubit: themeCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const AppDrawerView(backgroundOpacity: 0),
          mode: ThemeMode.dark,
          themeCubit: themeCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('logouts when logout list tile is tapped', (tester) async {
      await tester.pumpApp(
        const AppDrawerView(backgroundOpacity: 0),
        allCartoonsBloc: allCartoonsBloc,
        authenticationBloc: authenticationBloc,
        latestCartoonBloc: latestCartoonBloc,
        themeCubit: themeCubit,
      );
      await tester.tap(find.byKey(appDrawerLogoutTileKey));
      verify(allCartoonsBloc.close).called(1);
      verify(() => authenticationBloc.add(const Logout())).called(1);
      verify(latestCartoonBloc.close).called(1);
    });
  });
}
