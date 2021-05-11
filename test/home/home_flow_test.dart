import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/home/home_flow.dart';
import 'package:history_app/widgets/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../helpers/helpers.dart';

class MockTabBloc extends MockBloc<TabEvent, AppTab> implements TabBloc {}

class MockAllCartoonsBloc extends MockBloc<AllCartoonsEvent, AllCartoonsState>
    implements AllCartoonsBloc {}

class MockTagCubit extends MockCubit<Tag> implements TagCubit {}

class MockSortByCubit extends MockCubit<SortByMode> implements SortByCubit {}

class MockShowBottomSheetCubit extends MockCubit<bool>
    implements ShowBottomSheetCubit {}

class MockDailyCartoonBloc
    extends MockBloc<DailyCartoonEvent, DailyCartoonState>
    implements DailyCartoonBloc {}

void main() {
  group('HomeFlow', () {
    setupCloudFirestoreMocks();

    late TabBloc tabBloc;
    late AllCartoonsBloc allCartoonsBloc;
    late TagCubit tagCubit;
    late SortByCubit sortByCubit;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late DailyCartoonBloc dailyCartoonBloc;

    var dailyCartoonIconKey = find.byKey(const Key('TabSelector_DailyTab'));
    var allCartoonsIconKey = find.byKey(const Key('TabSelector_AllTab'));

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(AllCartoonsLoading());
      registerFallbackValue<AllCartoonsEvent>(
          LoadAllCartoons(SortByMode.latestPosted));
      registerFallbackValue<DailyCartoonState>(DailyCartoonInProgress());
      registerFallbackValue<DailyCartoonEvent>(LoadDailyCartoon());
      registerFallbackValue<TabEvent>(UpdateTab(AppTab.all));
      registerFallbackValue<AppTab>(AppTab.daily);
      registerFallbackValue<Tag>(Tag.all);
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);

      await Firebase.initializeApp();

      tabBloc = MockTabBloc();
      allCartoonsBloc = MockAllCartoonsBloc();
      tagCubit = MockTagCubit();
      sortByCubit = MockSortByCubit();
      showBottomSheetCubit = MockShowBottomSheetCubit();
      dailyCartoonBloc = MockDailyCartoonBloc();
    });

    testWidgets('finds TabSelector', (tester) async {
      var state = AppTab.daily;
      when(() => tabBloc.state).thenReturn(state);
      when(() => showBottomSheetCubit.state).thenReturn(false);
      when(() => dailyCartoonBloc.state).thenReturn(DailyCartoonInProgress());
      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: tabBloc,
        ),
        BlocProvider.value(value: dailyCartoonBloc),
        // BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: showBottomSheetCubit),
      ], child: HomeFlow()));
      //
      expect(find.byType(TabSelector), findsOneWidget);
    });

    testWidgets(
        'tabBloc.add(UpdateTab(AppTab.all)) '
        'is called when the "All" tab is tapped', (tester) async {
      var state = AppTab.daily;
      when(() => allCartoonsBloc.state).thenReturn(AllCartoonsLoading());
      when(() => tabBloc.state).thenReturn(state);
      when(() => dailyCartoonBloc.state).thenReturn(DailyCartoonInProgress());

      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: tagCubit,
        ),
        BlocProvider.value(
          value: tabBloc,
        ),
        BlocProvider.value(value: dailyCartoonBloc),
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: sortByCubit),
        BlocProvider.value(value: showBottomSheetCubit),
      ], child: HomeFlow()));

      expect(find.byType(DailyCartoonScreen), findsOneWidget);
      expect(find.byType(FilteredCartoonsScreen), findsNothing);

      await tester.tap(allCartoonsIconKey);
      verify(() => tabBloc.add(UpdateTab(AppTab.all))).called(1);
      await tester.pump();
      // expect(find.byType(DailyCartoonScreen), findsNothing);
      // expect(find.byType(FilteredCartoonsScreen), findsOneWidget);
      // Event called from onPageChanged and onTabSelect
      // verify(() => tabBloc.add(UpdateTab(AppTab.all))).called(2);
    });
    //
    // testWidgets(
    //     'tabBloc.add(UpdateTab(AppTab.daily)) '
    //     'is called when the "Daily" tab is tapped', (tester) async {
    //   var state = AppTab.all;
    //   when(() => allCartoonsBloc.state).thenReturn(AllCartoonsLoading());
    //   when(() => tabBloc.state).thenReturn(state);
    //
    //   await tester.pumpApp(MultiBlocProvider(providers: [
    //     BlocProvider.value(
    //       value: tagCubit,
    //     ),
    //     BlocProvider.value(
    //       value: tabBloc,
    //     ),
    //     BlocProvider.value(value: allCartoonsBloc),
    //     BlocProvider.value(value: sortByCubit),
    //     BlocProvider.value(value: showBottomSheetCubit),
    //   ], child: HomeFlow()));
    //
    //   expect(find.byType(FilteredCartoonsPage), findsOneWidget);
    //   expect(find.byType(DailyCartoonScreen), findsNothing);
    //
    //   await tester.tap(dailyCartoonIconKey);
    //   await tester.pump(const Duration(milliseconds: 1000));
    //
    //   expect(find.byType(DailyCartoonScreen), findsOneWidget);
    //   expect(find.byType(FilteredCartoonsPage), findsNothing);
    //
    //   verify(() => tabBloc.add(UpdateTab(AppTab.daily))).called(2);
    // });
  });
}
