import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/latest_cartoon/latest_cartoon.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('DailyCartoonView', () {
    late AllCartoonsBloc allCartoonsBloc;
    late LatestCartoonBloc latestCartoonBloc;
    late AppDrawerCubit appDrawerCubit;

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<LatestCartoonState>(FakeLatestCartoonState());
      registerFallbackValue<LatestCartoonEvent>(FakeLatestCartoonEvent());
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      appDrawerCubit = MockAppDrawerCubit();
      latestCartoonBloc = MockLatestCartoonBloc();

      final state = DailyCartoonLoaded(mockPoliticalCartoon);
      when(() => latestCartoonBloc.state).thenReturn(state);
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const DailyCartoonView(),
          latestCartoonBloc: latestCartoonBloc,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const DailyCartoonView(),
          latestCartoonBloc: latestCartoonBloc,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets(
      'renders widget with '
      'Key(\'DailyCartoonView_DailyCartoonInProgress\') '
      'when state is DailyCartoonInProgress()', (tester) async {
      final state = const DailyCartoonInProgress();
      when(() => latestCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(
        const DailyCartoonView(),
        latestCartoonBloc: latestCartoonBloc,
      );
      expect(find.byKey(latestCartoonInProgressKey), findsOneWidget);
    });

    testWidgets(
      'renders widget with Key(\'DailyCartoonView_DailyCartoonLoaded\') '
      'when state is DailyCartoonLoaded', (tester) async {
      await tester.pumpApp(
        const DailyCartoonView(),
        latestCartoonBloc: latestCartoonBloc,
      );
      expect(find.byKey(latestCartoonLoadedKey), findsOneWidget);
    });

    testWidgets(
      'renders widget with Key(\'DailyCartoonView_DailyCartoonFailed\') '
      'when state is DailyCartoonFailed', (tester) async {
      final state = const DailyCartoonFailed('Error');
      when(() => latestCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(
        const DailyCartoonView(),
        latestCartoonBloc: latestCartoonBloc,
      );
      expect(find.byKey(latestCartoonFailedKey), findsOneWidget);
    });

    testWidgets('open drawer when menu icon is tapped', (tester) async {
      final state = const DailyCartoonFailed('Error');
      when(() => latestCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(
        const DailyCartoonView(),
        allCartoonsBloc: allCartoonsBloc,
        appDrawerCubit: appDrawerCubit,
        latestCartoonBloc: latestCartoonBloc,
      );
      await tester.tap(find.byKey(latestCartoonMenuButtonKey));
      verify(appDrawerCubit.openDrawer).called(1);
    });
  });
}
