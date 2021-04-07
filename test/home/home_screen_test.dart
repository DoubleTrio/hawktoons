import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
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
    var dailyText = find.text('Daily');
    var allText = find.text('All');

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
    });

    testWidgets(
        'tabBloc.add(UpdateTab(AppTab.all))) '
        'is called when the all tab is tapped', (tester) async {
      var state = AppTab.daily;
      when(() => tabBloc.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: tabBloc,
          child: HomeScreen(),
        ),
      );
      expect(find.byType(TabSelector), findsOneWidget);
      await tester.tap(allText);
      verify(() => tabBloc.add(UpdateTab(AppTab.all))).called(1);
    });

    testWidgets(
        'tabBloc.add(UpdateTab(AppTab.daily))) '
        'is called when the daily tab is tapped', (tester) async {
      var state = AppTab.all;
      when(() => tabBloc.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: tabBloc,
          child: HomeScreen(),
        ),
      );
      await tester.tap(dailyText);
      verify(() => tabBloc.add(UpdateTab(AppTab.daily))).called(1);
    });
  });
}
