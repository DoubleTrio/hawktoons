import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('DailyCartoonView', () {
    late DailyCartoonBloc dailyCartoonBloc;
    late AllCartoonsBloc allCartoonsBloc;
    late AuthenticationBloc authenticationBloc;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: dailyCartoonBloc),
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: authenticationBloc),
      ], child: child);
    }

    setUpAll(() {
      registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
      registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
    });

    setUp(() {
      dailyCartoonBloc = MockDailyCartoonBloc();
      allCartoonsBloc = MockAllCartoonsBloc();
      authenticationBloc = MockAuthenticationBloc();
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        final state = DailyCartoonLoaded(mockPoliticalCartoon);
        when(() => dailyCartoonBloc.state).thenReturn(state);
        await mockNetworkImagesFor(
          () => tester.pumpApp(wrapper(const DailyCartoonView())),
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        final state = DailyCartoonLoaded(mockPoliticalCartoon);
        when(() => dailyCartoonBloc.state).thenReturn(state);
        await mockNetworkImagesFor(
          () => tester.pumpApp(
            wrapper(const DailyCartoonView()),
            mode: ThemeMode.dark,
          ),
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
      await tester.pumpApp(wrapper(const DailyCartoonView()));
      expect(find.byKey(dailyCartoonInProgressKey), findsOneWidget);
    });

    testWidgets(
      'renders widget with Key(\'DailyCartoonView_DailyCartoonLoaded\') '
      'when state is DailyCartoonLoaded', (tester) async {
      final state = DailyCartoonLoaded(mockPoliticalCartoon);
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(const DailyCartoonView()))
      );
      expect(find.byKey(dailyCartoonLoadedKey), findsOneWidget);
    });

    testWidgets(
      'renders widget with Key(\'DailyCartoonView_DailyCartoonFailed\') '
      'when state is DailyCartoonFailed', (tester) async {
      final state = const DailyCartoonFailed('Error');
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(wrapper(const DailyCartoonView()));
      expect(find.byKey(dailyCartoonFailedKey), findsOneWidget);
    });

    testWidgets('logs out when logout button is tapped', (tester) async {
      final state = const DailyCartoonFailed('Error');
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(wrapper(const DailyCartoonView()));
      await tester.tap(find.byKey(dailyCartoonLogoutButtonKey));
      verify(() => authenticationBloc.add(const Logout())).called(1);
      verify(allCartoonsBloc.close).called(1);
      verify(dailyCartoonBloc.close).called(1);
    });
  });
}
