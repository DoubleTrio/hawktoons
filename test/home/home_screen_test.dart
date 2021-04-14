import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/daily_cartoon/view/daily_cartoon_page.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:history_app/home/home_screen.dart';
import 'package:history_app/widgets/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../helpers/helpers.dart';

class MockTabBloc extends MockBloc<TabEvent, AppTab> implements TabBloc {}

class MockAllCartoonsBloc extends MockBloc<AllCartoonsEvent, AllCartoonsState>
    implements AllCartoonsBloc {}

class MockUnitCubit extends MockCubit<Unit> implements UnitCubit {}

void main() {
  group('HomeScreen', () {
    setupCloudFirestoreMocks();

    late TabBloc tabBloc;
    late AllCartoonsBloc allCartoonsBloc;
    late UnitCubit unitCubit;

    var dailyCartoonIconKey = find.byKey(const Key('TabSelector_DailyTab'));
    var allCartoonsIconKey = find.byKey(const Key('TabSelector_AllTab'));

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(AllCartoonsLoading());
      registerFallbackValue<AllCartoonsEvent>(LoadAllCartoons());
      registerFallbackValue<TabEvent>(UpdateTab(AppTab.all));
      registerFallbackValue<AppTab>(AppTab.daily);
      registerFallbackValue<Unit>(Unit.all);

      await Firebase.initializeApp();

      tabBloc = MockTabBloc();
      allCartoonsBloc = MockAllCartoonsBloc();
      unitCubit = MockUnitCubit();
    });

    testWidgets('finds TabSelector', (tester) async {
      var state = AppTab.daily;
      when(() => tabBloc.state).thenReturn(state);

      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: tabBloc,
        ),
        BlocProvider.value(value: allCartoonsBloc)
      ], child: HomeScreen()));

      expect(find.byType(TabSelector), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets(
        'tabBloc.add(UpdateTab(AppTab.all)) '
        'is called when the "All" tab is tapped', (tester) async {
      var state = AppTab.daily;
      when(() => allCartoonsBloc.state).thenReturn(AllCartoonsLoading());
      when(() => tabBloc.state).thenReturn(state);

      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: unitCubit,
        ),
        BlocProvider.value(
          value: tabBloc,
        ),
        BlocProvider.value(value: allCartoonsBloc)
      ], child: HomeScreen()));

      expect(find.byType(DailyCartoonPage), findsOneWidget);
      expect(find.byType(FilteredCartoonsPage), findsNothing);

      await tester.tap(allCartoonsIconKey);
      await tester.pump(const Duration(milliseconds: 1000));

      expect(find.byType(FilteredCartoonsPage), findsOneWidget);
      expect(find.byType(DailyCartoonPage), findsNothing);

      // Event called from onPageChanged and onTabSelect
      verify(() => tabBloc.add(UpdateTab(AppTab.all))).called(2);
    });

    testWidgets(
        'tabBloc.add(UpdateTab(AppTab.daily)) '
        'is called when the "Daily" tab is tapped', (tester) async {
      var state = AppTab.all;
      when(() => allCartoonsBloc.state).thenReturn(AllCartoonsLoading());
      when(() => tabBloc.state).thenReturn(state);

      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: unitCubit,
        ),
        BlocProvider.value(
          value: tabBloc,
        ),
        BlocProvider.value(value: allCartoonsBloc)
      ], child: HomeScreen()));

      expect(find.byType(FilteredCartoonsPage), findsOneWidget);
      expect(find.byType(DailyCartoonPage), findsNothing);

      await tester.tap(dailyCartoonIconKey);
      await tester.pump(const Duration(milliseconds: 1000));

      expect(find.byType(DailyCartoonPage), findsOneWidget);
      expect(find.byType(FilteredCartoonsPage), findsNothing);

      // Event called from onPageChanged and onTabSelect
      verify(() => tabBloc.add(UpdateTab(AppTab.daily))).called(2);
    });
  });
}
