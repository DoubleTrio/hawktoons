import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/auth/bloc/auth.dart';
import 'package:hawktoons/daily_cartoon/daily_cartoon.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('DailyCartoonView', () {
    late AllCartoonsBloc allCartoonsBloc;
    late AuthenticationBloc authenticationBloc;
    late DailyCartoonBloc dailyCartoonBloc;

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
      registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      authenticationBloc = MockAuthenticationBloc();
      dailyCartoonBloc = MockDailyCartoonBloc();

      final state = DailyCartoonLoaded(mockPoliticalCartoon);
      when(() => dailyCartoonBloc.state).thenReturn(state);
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const DailyCartoonView(),
          dailyCartoonBloc: dailyCartoonBloc,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const DailyCartoonView(),
          dailyCartoonBloc: dailyCartoonBloc,
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
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(
        const DailyCartoonView(),
        dailyCartoonBloc: dailyCartoonBloc,
      );
      expect(find.byKey(dailyCartoonInProgressKey), findsOneWidget);
    });

    testWidgets(
      'renders widget with Key(\'DailyCartoonView_DailyCartoonLoaded\') '
      'when state is DailyCartoonLoaded', (tester) async {
      await tester.pumpApp(
        const DailyCartoonView(),
        dailyCartoonBloc: dailyCartoonBloc,
      );
      expect(find.byKey(dailyCartoonLoadedKey), findsOneWidget);
    });

    testWidgets(
      'renders widget with Key(\'DailyCartoonView_DailyCartoonFailed\') '
      'when state is DailyCartoonFailed', (tester) async {
      final state = const DailyCartoonFailed('Error');
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(
        const DailyCartoonView(),
        dailyCartoonBloc: dailyCartoonBloc,
      );
      expect(find.byKey(dailyCartoonFailedKey), findsOneWidget);
    });

    testWidgets('logs out when logout button is tapped', (tester) async {
      final state = const DailyCartoonFailed('Error');
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(
        const DailyCartoonView(),
        authenticationBloc: authenticationBloc,
        allCartoonsBloc: allCartoonsBloc,
        dailyCartoonBloc: dailyCartoonBloc,
      );
      await tester.tap(find.byKey(dailyCartoonLogoutButtonKey));
      verify(() => authenticationBloc.add(const Logout())).called(1);
      verify(allCartoonsBloc.close).called(1);
      verify(dailyCartoonBloc.close).called(1);
    });
  });
}
