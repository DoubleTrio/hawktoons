import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    setupCloudFirestoreMocks();

    late ThemeCubit themeCubit;
    late TabBloc tabBloc;
    late AllCartoonsBloc allCartoonsBloc;
    late TagCubit tagCubit;
    late SortByCubit sortByCubit;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late DailyCartoonBloc dailyCartoonBloc;
    late ScrollHeaderCubit scrollHeaderCubit;
    late SelectCartoonCubit selectCartoonCubit;
    late ImageTypeCubit imageTypeCubit;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: themeCubit),
        BlocProvider.value(value: tagCubit),
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: sortByCubit),
        BlocProvider.value(value: showBottomSheetCubit),
        BlocProvider.value(value: dailyCartoonBloc),
        BlocProvider.value(value: tabBloc),
        BlocProvider.value(value: scrollHeaderCubit),
        BlocProvider.value(value: selectCartoonCubit),
        BlocProvider.value(value: imageTypeCubit)
      ], child: child);
    }

    setUpAll(() async {
      await Firebase.initializeApp();
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
      registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
      registerFallbackValue<SelectPoliticalCartoonState>(
        FakeSelectPoliticalCartoonState()
      );
      registerFallbackValue<TabEvent>(FakeTabEvent());
      registerFallbackValue<AppTab>(AppTab.daily);
      registerFallbackValue<Tag>(Tag.all);
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);
      registerFallbackValue<ThemeMode>(ThemeMode.light);
      registerFallbackValue<ImageType>(ImageType.all);

      themeCubit = MockThemeCubit();
      tabBloc = MockTabBloc();
      allCartoonsBloc = MockAllCartoonsBloc();
      tagCubit = MockTagCubit();
      sortByCubit = MockSortByCubit();
      showBottomSheetCubit = MockShowBottomSheetCubit();
      dailyCartoonBloc = MockDailyCartoonBloc();
      scrollHeaderCubit = MockScrollHeaderCubit();
      selectCartoonCubit = MockSelectCartoonCubit();
      imageTypeCubit = MockImageTypeCubit();

      when(() => allCartoonsBloc.state)
        .thenReturn(const AllCartoonsState.initial());
      when(() => showBottomSheetCubit.state).thenReturn(false);
      when(() => dailyCartoonBloc.state).thenReturn(DailyCartoonInProgress());
      when(() => selectCartoonCubit.state)
        .thenReturn(SelectPoliticalCartoonState());
      when(() => imageTypeCubit.state).thenReturn(ImageType.all);
    });

    group('TabSelector', () {
      testWidgets('finds TabSelector', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.daily);
        await tester.pumpApp(wrapper(const HomeFlow()));
        expect(find.byType(TabSelector), findsOneWidget);
      });

      testWidgets(
        'tabBloc.add(UpdateTab(AppTab.all)) '
        'is invoked when the "All" tab is tapped', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.daily);
        await tester.pumpApp(wrapper(const HomeFlow()));
        await tester.tap(find.byKey(allCartoonTabKey));
        verify(() => tabBloc.add(UpdateTab(AppTab.all))).called(1);
      });

      testWidgets(
        'tabBloc.add(UpdateTab(AppTab.daily)) '
        'is invoked when the "Daily" tab is tapped', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.all);
        when(() => scrollHeaderCubit.state).thenReturn(false);

        await tester.pumpApp(wrapper(const HomeFlow()));
        await tester.tap(find.byKey(dailyCartoonTabKey));
        verify(() => tabBloc.add(UpdateTab(AppTab.daily))).called(1);
      });

      testWidgets('changes theme when theme tab is tapped', (tester) async {
        when(() => tabBloc.state).thenReturn(AppTab.daily);
        when(() => scrollHeaderCubit.state).thenReturn(false);
        when(() => themeCubit.state).thenReturn(ThemeMode.dark);

        await tester.pumpApp(wrapper(const HomeFlow()));
        await tester.tap(find.byKey(changeThemeTabKey));
        verify(themeCubit.changeTheme).called(1);

        await tester.tap(find.byKey(changeThemeTabKey));
        verify(themeCubit.changeTheme).called(1);
      });
    });

    group('FilterPopUp', () {
      setUp(() {
        when(() => tabBloc.state).thenReturn(AppTab.daily);
        when(() => tagCubit.state).thenReturn(Tag.all);
        when(() => sortByCubit.state).thenReturn(SortByMode.earliestPosted);
        whenListen(showBottomSheetCubit, Stream.value(true));
      });

      testWidgets('shows filter pop up and closes', (tester) async {
        await tester.pumpApp(wrapper(const HomeFlow()));
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(FilterPopUp), findsOneWidget);
        await tester.tapAt(const Offset(0, 500));
        verify(showBottomSheetCubit.closeSheet).called(1);
      });
    });
  });
}
