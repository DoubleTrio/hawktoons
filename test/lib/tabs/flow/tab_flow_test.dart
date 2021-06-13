import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
import 'package:hawktoons/latest_cartoon/latest_cartoon.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  final allCartoonsPageInitial = const AllCartoonsPageState.initial();

  group('TabFlow', () {
    late AllCartoonsBloc allCartoonsBloc;
    late AllCartoonsPageCubit allCartoonsPageCubit;
    late AuthenticationBloc authenticationBloc;
    late LatestCartoonBloc latestCartoonBloc;
    late ImageTypeCubit imageTypeCubit;
    late SettingsScreenCubit settingsScreenCubit;
    late SortByCubit sortByCubit;
    late TabBloc tabBloc;
    late TagCubit tagCubit;

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<AllCartoonsPageState>(FakeAllCartoonsPageState());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AppTab>(AppTab.latest);
      registerFallbackValue<LatestCartoonState>(FakeLatestCartoonState());
      registerFallbackValue<LatestCartoonEvent>(FakeLatestCartoonEvent());
      registerFallbackValue<ImageType>(ImageType.all);
      registerFallbackValue<SettingsScreen>(SettingsScreen.main);
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);
      registerFallbackValue<TabEvent>(FakeTabEvent());
      registerFallbackValue<Tag>(Tag.all);
    });

    setUp(() {
      allCartoonsPageCubit = MockAllCartoonsPageCubit();
      allCartoonsBloc = MockAllCartoonsBloc();
      authenticationBloc = MockAuthenticationBloc();
      latestCartoonBloc = MockLatestCartoonBloc();
      tabBloc = MockTabBloc();
      tagCubit = MockTagCubit();
      sortByCubit = MockSortByCubit();
      imageTypeCubit = MockImageTypeCubit();
      settingsScreenCubit = MockSettingsScreenCubit();

      when(() => allCartoonsBloc.state)
        .thenReturn(
          const AllCartoonsState.initial(view: CartoonView.staggered)
        );
      when(() => allCartoonsPageCubit.state).thenReturn(
        allCartoonsPageInitial
      );
      when(() => authenticationBloc.state).thenReturn(
        const AuthenticationState(status: AuthenticationStatus.authenticated)
      );
      when(() => imageTypeCubit.state).thenReturn(ImageType.all);
      when(() => latestCartoonBloc.state).thenReturn(
        const DailyCartoonInProgress()
      );
      when(() => tabBloc.state).thenReturn(AppTab.latest);
    });


    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const TabFlow(),
          allCartoonsPageCubit: allCartoonsPageCubit,
          latestCartoonBloc: latestCartoonBloc,
          tabBloc: tabBloc,
        );

        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const TabFlow(),
          mode: ThemeMode.dark,
          allCartoonsPageCubit: allCartoonsPageCubit,
          latestCartoonBloc: latestCartoonBloc,
          tabBloc: tabBloc,
        );

        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    group('TabSelector', () {
      testWidgets('finds TabSelector', (tester) async {
        await tester.pumpApp(
          const TabFlow(),
          allCartoonsPageCubit: allCartoonsPageCubit,
          latestCartoonBloc: latestCartoonBloc,
          tabBloc: tabBloc,
        );
        expect(find.byType(TabSelector), findsOneWidget);
      });

      testWidgets(
        'tabBloc.add(UpdateTab(AppTab.latest)) '
        'is invoked when the "Latest" tab is tapped', (tester) async {
        await tester.pumpApp(
          const TabFlow(),
          allCartoonsPageCubit: allCartoonsPageCubit,
          latestCartoonBloc: latestCartoonBloc,
          tabBloc: tabBloc,
        );
        await tester.tap(find.byKey(latestCartoonTabKey));
        verify(() => tabBloc.add(UpdateTab(AppTab.latest))).called(1);
      });
    });

    testWidgets(
      'tabBloc.add(UpdateTab(AppTab.settings)) '
      'is invoked when the "Settings" tab is tapped', (tester) async {
      await tester.pumpApp(
        const TabFlow(),
        allCartoonsPageCubit: allCartoonsPageCubit,
        latestCartoonBloc: latestCartoonBloc,
        tabBloc: tabBloc,
      );
      await tester.tap(find.byKey(settingsTabKey));
      verify(() => tabBloc.add(UpdateTab(AppTab.settings))).called(1);
    });

    testWidgets(
      'tabBloc.add(UpdateTab(AppTab.all)) '
      'is invoked when the "All" tab is tapped', (tester) async {
      await tester.pumpApp(
        const TabFlow(),
        allCartoonsPageCubit: allCartoonsPageCubit,
        latestCartoonBloc: latestCartoonBloc,
        tabBloc: tabBloc,
      );
      await tester.tap(find.byKey(allCartoonTabKey));
      verify(() => tabBloc.add(UpdateTab(AppTab.all))).called(1);
    });

    testWidgets('renders all cartoons view', (tester) async {
      when(() => tabBloc.state).thenReturn(AppTab.all);
      await tester.pumpApp(
        const TabFlow(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
        tabBloc: tabBloc,
      );
      expect(find.byType(AllCartoonsView), findsOneWidget);
    });

    testWidgets('renders SettingsFlowView', (tester) async {
      when(() => tabBloc.state).thenReturn(AppTab.settings);
      when(() => settingsScreenCubit.state).thenReturn(SettingsScreen.main);
      await tester.pumpApp(
        const TabFlow(),
        allCartoonsPageCubit: allCartoonsPageCubit,
        settingsScreenCubit: settingsScreenCubit,
        tabBloc: tabBloc,
      );
      expect(find.byType(SettingsFlowView), findsOneWidget);
    });

    group('FilterPopUp', () {
      setUp(() {
        when(() => tabBloc.state).thenReturn(AppTab.all);
        when(() => tagCubit.state).thenReturn(Tag.all);
        when(() => sortByCubit.state).thenReturn(SortByMode.earliestPosted);
        whenListen(allCartoonsPageCubit, Stream.value(
          allCartoonsPageInitial.copyWith(shouldShowFilterSheet: true)
        ));
      });

      testWidgets('shows filter pop up and closes', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.latest);
        await tester.pumpApp(
          const TabFlow(),
          mode: ThemeMode.dark,
          allCartoonsPageCubit: allCartoonsPageCubit,
          latestCartoonBloc: latestCartoonBloc,
          imageTypeCubit: imageTypeCubit,
          sortByCubit: sortByCubit,
          tabBloc: tabBloc,
          tagCubit: tagCubit,
        );
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(FilterPopUp), findsOneWidget);
        await tester.tapAt(const Offset(0, 500));
        verify(allCartoonsPageCubit.closeFilterSheet).called(1);
      });
    });

    group('CreateCartoonPopUp', () {
      testWidgets('shows create cartoon pop up and closes', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.latest);
        when(() => tagCubit.state).thenReturn(Tag.all);
        when(() => sortByCubit.state).thenReturn(SortByMode.earliestPosted);
        whenListen(allCartoonsPageCubit, Stream.value(
          allCartoonsPageInitial.copyWith(shouldShowCreateCartoonSheet: true)
        ));
        await tester.pumpApp(
          const TabFlow(),
          allCartoonsPageCubit: allCartoonsPageCubit,
          latestCartoonBloc: latestCartoonBloc,
          imageTypeCubit: imageTypeCubit,
          sortByCubit: sortByCubit,
          tabBloc: tabBloc,
          tagCubit: tagCubit,
        );
        await tester.pump(const Duration(seconds: 2));
        expect(find.byType(CreateCartoonPopUp), findsOneWidget);
        await tester.tapAt(const Offset(0, 500));
        await tester.pump(const Duration(seconds: 2));
        verify(allCartoonsPageCubit.closeCreateCartoonSheet).called(1);
      });
    });
  });
}
