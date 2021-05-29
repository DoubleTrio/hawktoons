import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/app_drawer/view/drawer_stack_page.dart';
import 'package:hawktoons/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:hawktoons/daily_cartoon/daily_cartoon.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:hawktoons/theme/cubit/theme_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('DrawerStackPage', () {
    late AppDrawerCubit appDrawerCubit;
    late DailyCartoonBloc dailyCartoonBloc;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late TabBloc tabBloc;
    late ThemeCubit themeCubit;

    setUpAll(() {
      registerFallbackValue<AppTab>(AppTab.daily);
      registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
      registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
      registerFallbackValue<TabEvent>(FakeTabEvent());
      registerFallbackValue<ThemeMode>(ThemeMode.light);
    });

    setUp(() {
      appDrawerCubit = MockAppDrawerCubit();
      dailyCartoonBloc = MockDailyCartoonBloc();
      showBottomSheetCubit = MockShowBottomSheetCubit();
      tabBloc = MockTabBloc();
      themeCubit = MockThemeCubit();

      when(() => dailyCartoonBloc.state).thenReturn(
        const DailyCartoonInProgress()
      );
      when(() => showBottomSheetCubit.state).thenReturn(false);
      when(() => tabBloc.state).thenReturn(AppTab.daily);
      when(() => themeCubit.state).thenReturn(ThemeMode.light);
    });

    group('DrawerStackView', () {
      testWidgets('opens drawer when swiped to the right', (tester) async {
        when(() => appDrawerCubit.state).thenReturn(false);
        await tester.pumpApp(
          const DrawerStackView(),
          appDrawerCubit: appDrawerCubit,
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
          themeCubit: themeCubit,
        );
        await tester.fling(
          find.byType(DailyCartoonView),
          const Offset(600, 0),
          80,
        );
        verify(appDrawerCubit.openDrawer).called(1);
        expect(find.byType(AppDrawerPage), findsOneWidget);
      });

      testWidgets('does not open drawer when '
        'swiped to the right not far enough', (tester) async {
        when(() => appDrawerCubit.state).thenReturn(false);
        await tester.pumpApp(
          const DrawerStackView(),
          appDrawerCubit: appDrawerCubit,
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
          themeCubit: themeCubit,
        );
        await tester.fling(
          find.byType(DailyCartoonView),
          const Offset(100, 0),
          20,
        );
        await tester.pump(const Duration(seconds: 1));
        await tester.pump(const Duration(seconds: 1));
        verifyNever(appDrawerCubit.openDrawer);
        expect(find.byType(AppDrawerPage), findsOneWidget);
      });

      testWidgets('creates velocity fling animation', (tester) async {
        when(() => appDrawerCubit.state).thenReturn(false);
        await tester.pumpApp(
          const DrawerStackView(),
          appDrawerCubit: appDrawerCubit,
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
          themeCubit: themeCubit,
        );
        await tester.fling(
          find.byType(DailyCartoonView),
          const Offset(300, 0),
          3000,
        );
      });

      testWidgets('does open drawer '
          'when swiped right just enough (animation forwards)', (tester) async {
        when(() => appDrawerCubit.state).thenReturn(false);
        await tester.pumpApp(
          const DrawerStackView(),
          appDrawerCubit: appDrawerCubit,
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
          themeCubit: themeCubit,
        );

        await tester.fling(
          find.byType(DailyCartoonView),
          const Offset(200, 0),
          60,
        );

        await tester.pump(const Duration(seconds: 1));
        await tester.pump(const Duration(seconds: 1));
        verify(appDrawerCubit.openDrawer).called(1);
      });

      testWidgets('closes drawer when swiped to the left '
        'when drawer is open (animation reverses)', (tester) async {
        whenListen(appDrawerCubit, Stream.value(true), initialState: false);

        await tester.pumpApp(
          const DrawerStackView(),
          appDrawerCubit: appDrawerCubit,
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
          themeCubit: themeCubit,
        );
        await tester.pump();
        await tester.fling(
          find.byType(AppDrawerPage),
          const Offset(-600, 0),
          80,
        );
        verify(appDrawerCubit.closeDrawer).called(1);
        expect(find.byType(DailyCartoonView), findsOneWidget);
      });

      testWidgets('closes drawer when '
        'DailyCartoonView is tapped', (tester) async {
        whenListen(appDrawerCubit, Stream.value(true), initialState: false);

        await tester.pumpApp(
          const DrawerStackView(),
          appDrawerCubit: appDrawerCubit,
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
          themeCubit: themeCubit,
        );

        await tester.pump();

        await tester.tap(find.byType(DailyCartoonView));
        verify(appDrawerCubit.closeDrawer).called(1);
        expect(find.byType(DailyCartoonView), findsOneWidget);
      });
    });
  });
}
