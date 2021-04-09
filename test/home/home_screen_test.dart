import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/view/all_cartoons_page.dart';
import 'package:history_app/daily_cartoon/view/daily_cartoon_page.dart';
import 'package:history_app/home/home_screen.dart';
import 'package:history_app/tab/tab.dart';
import 'package:history_app/widgets/widgets.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

class MockTabBloc extends MockBloc<TabEvent, AppTab> implements TabBloc {}

void main() {
  group('HomeScreen', () {
    setupCloudFirestoreMocks();

    late TabBloc tabBloc;

    var dailyCartoonIconKey = find.byKey(const Key('TabSelector_DailyTab'));
    var allCartoonsIconKey = find.byKey(const Key('TabSelector_AllTab'));

    setUpAll(() async {
      registerFallbackValue<TabEvent>(UpdateTab(AppTab.all));
      registerFallbackValue<AppTab>(AppTab.daily);

      await Firebase.initializeApp();

      tabBloc = MockTabBloc();
    });

    testWidgets('finds TabSelector', (tester) async {
      var state = AppTab.daily;
      when(() => tabBloc.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: tabBloc,
          child: HomeScreen(),
        ),
      );
      expect(find.byType(TabSelector), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets(
        'tabBloc.add(UpdateTab(AppTab.all)) '
        'is called when the "All" tab is tapped', (tester) async {
      var state = AppTab.daily;
      when(() => tabBloc.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: tabBloc,
          child: HomeScreen(),
        ),
      );

      expect(find.byType(DailyCartoonPage), findsOneWidget);
      expect(find.byType(AllCartoonsPage), findsNothing);

      await tester.tap(allCartoonsIconKey);
      await tester.pump(const Duration(milliseconds: 1000));

      expect(find.byType(AllCartoonsPage), findsOneWidget);
      expect(find.byType(DailyCartoonPage), findsNothing);

      // Event called from onPageChanged and onTabSelect
      verify(() => tabBloc.add(UpdateTab(AppTab.all))).called(2);
    });

    testWidgets(
        'tabBloc.add(UpdateTab(AppTab.daily)) '
        'is called when the "Daily" tab is tapped', (tester) async {
      var state = AppTab.all;
      when(() => tabBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: tabBloc,
          child: HomeScreen(),
        ),
      );

      expect(find.byType(AllCartoonsPage), findsOneWidget);
      expect(find.byType(DailyCartoonPage), findsNothing);

      await tester.tap(dailyCartoonIconKey);
      await tester.pump(const Duration(milliseconds: 1000));

      expect(find.byType(DailyCartoonPage), findsOneWidget);
      expect(find.byType(AllCartoonsPage), findsNothing);

      // Event called from onPageChanged and onTabSelect
      verify(() => tabBloc.add(UpdateTab(AppTab.daily))).called(2);
    });

    testWidgets(
        'tabBloc.add(UpdateTab(AppTab.daily)) '
        'is called when swiped to "Daily" tab', (tester) async {
      var state = AppTab.all;
      when(() => tabBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: tabBloc,
          child: HomeScreen(),
        ),
      );

      await tester.fling(find.byType(Scaffold), const Offset(500, 0), 3000);

      verify(() => tabBloc.add(UpdateTab(AppTab.daily))).called(1);
    });

    testWidgets(
        'tabBloc.add(UpdateTab(AppTab.all)) '
        'is called when swiped to "All" tab', (tester) async {
      var state = AppTab.daily;
      when(() => tabBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: tabBloc,
          child: HomeScreen(),
        ),
      );

      await tester.fling(find.byType(Scaffold), const Offset(-500, 0), 3000);

      verify(() => tabBloc.add(UpdateTab(AppTab.all))).called(1);
    });
  });
}
