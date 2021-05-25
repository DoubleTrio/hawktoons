import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/home/home.dart';
import 'package:history_app/theme/theme.dart';
import 'package:history_app/widgets/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('HomeFlow', () {
    late AllCartoonsBloc allCartoonsBloc;
    late DailyCartoonBloc dailyCartoonBloc;
    late ImageTypeCubit imageTypeCubit;
    late ScrollHeaderCubit scrollHeaderCubit;
    late SelectCartoonCubit selectCartoonCubit;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late SortByCubit sortByCubit;
    late TabBloc tabBloc;
    late TagCubit tagCubit;
    late ThemeCubit themeCubit;

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<AppTab>(AppTab.daily);
      registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
      registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
      registerFallbackValue<ImageType>(ImageType.all);
      registerFallbackValue<SelectPoliticalCartoonState>(
          FakeSelectPoliticalCartoonState()
      );
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);
      registerFallbackValue<ThemeMode>(ThemeMode.light);
      registerFallbackValue<TabEvent>(FakeTabEvent());
      registerFallbackValue<Tag>(Tag.all);
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      dailyCartoonBloc = MockDailyCartoonBloc();
      selectCartoonCubit = MockSelectCartoonCubit();
      tabBloc = MockTabBloc();
      tagCubit = MockTagCubit();
      sortByCubit = MockSortByCubit();
      imageTypeCubit = MockImageTypeCubit();
      themeCubit = MockThemeCubit();
      showBottomSheetCubit = MockShowBottomSheetCubit();
      scrollHeaderCubit = MockScrollHeaderCubit();

      when(() => allCartoonsBloc.state)
        .thenReturn(const AllCartoonsState.initial());
      when(() => showBottomSheetCubit.state).thenReturn(false);
      when(() => dailyCartoonBloc.state).thenReturn(
        const DailyCartoonInProgress()
      );
      when(() => selectCartoonCubit.state)
        .thenReturn(const SelectPoliticalCartoonState());
      when(() => imageTypeCubit.state).thenReturn(ImageType.all);
      when(() => scrollHeaderCubit.state).thenReturn(false);
    });


    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.daily);
        await tester.pumpApp(
          const HomeFlow(),
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
        );

        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.daily);
        await tester.pumpApp(
          const HomeFlow(),
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
        );

        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    group('TabSelector', () {
      testWidgets('finds TabSelector', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.daily);
        await tester.pumpApp(
          const HomeFlow(),
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
        );
        expect(find.byType(TabSelector), findsOneWidget);
      });

      testWidgets(
        'tabBloc.add(UpdateTab(AppTab.all)) '
        'is invoked when the "All" tab is tapped', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.daily);
        await tester.pumpApp(
          const HomeFlow(),
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
        );
        await tester.tap(find.byKey(allCartoonTabKey));
        verify(() => tabBloc.add(UpdateTab(AppTab.all))).called(1);
      });

      testWidgets(
        'tabBloc.add(UpdateTab(AppTab.daily)) '
        'is invoked when the "Daily" tab is tapped', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.all);

        await tester.pumpApp(
          const HomeFlow(),
          allCartoonsBloc: allCartoonsBloc,
          selectCartoonCubit: selectCartoonCubit,
          scrollHeaderCubit: scrollHeaderCubit,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
        );
        await tester.tap(find.byKey(dailyCartoonTabKey));
        verify(() => tabBloc.add(UpdateTab(AppTab.daily))).called(1);
      });

      testWidgets('changes theme when theme tab is tapped', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.daily);
        when(() => themeCubit.state).thenReturn(ThemeMode.dark);

        await tester.pumpApp(
          const HomeFlow(),
          dailyCartoonBloc: dailyCartoonBloc,
          showBottomSheetCubit: showBottomSheetCubit,
          tabBloc: tabBloc,
          themeCubit: themeCubit,
        );

        await tester.tap(find.byKey(changeThemeTabKey));
        verify(themeCubit.changeTheme).called(1);

        await tester.tap(find.byKey(changeThemeTabKey));
        verify(themeCubit.changeTheme).called(1);
      });
    });

    group('FilterPopUp', () {
      setUp(() {
        when(() => tabBloc.state).thenReturn(AppTab.all);
        when(() => tagCubit.state).thenReturn(Tag.all);
        when(() => sortByCubit.state).thenReturn(SortByMode.earliestPosted);
        whenListen(showBottomSheetCubit, Stream.value(true));
      });

      testWidgets('shows filter pop up and closes', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.daily);
        await tester.pumpApp(
          const HomeFlow(),
          mode: ThemeMode.dark,
          dailyCartoonBloc: dailyCartoonBloc,
          imageTypeCubit: imageTypeCubit,
          showBottomSheetCubit: showBottomSheetCubit,
          sortByCubit: sortByCubit,
          tabBloc: tabBloc,
          tagCubit: tagCubit,
        );
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(FilterPopUp), findsOneWidget);
        await tester.tapAt(const Offset(0, 500));
        verify(showBottomSheetCubit.closeSheet).called(1);
      });
    });
  });
}
