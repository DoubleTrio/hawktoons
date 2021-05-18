import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('DailyCartoonScreen', () {
    late DailyCartoonBloc dailyCartoonBloc;
    late AuthenticationBloc authenticationBloc;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: dailyCartoonBloc),
        BlocProvider.value(value: authenticationBloc),
      ], child: child);
    }

    setUpAll(() async {
      registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
      registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());

      dailyCartoonBloc = MockDailyCartoonBloc();
      authenticationBloc = MockAuthenticationBloc();
    });

    testWidgets(
        'renders widget with '
        'Key(\'DailyCartoonScreen_DailyCartoonInProgress\') '
        'when state is DailyCartoonInProgress()', (tester) async {
      var state = DailyCartoonInProgress();
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(wrapper(DailyCartoonScreen()));
      expect(find.byKey(dailyCartoonInProgressKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with Key(\'DailyCartoonScreen_DailyCartoonLoaded\') '
        'when state is DailyCartoonLoaded', (tester) async {
      var state = DailyCartoonLoaded(mockPoliticalCartoon);
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await mockNetworkImagesFor(
          () => tester.pumpApp(wrapper(DailyCartoonScreen())));
      expect(find.byKey(dailyCartoonLoadedKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with Key(\'DailyCartoonScreen_DailyCartoonFailed\') '
        'when state is DailyCartoonFailed', (tester) async {
      var state = DailyCartoonFailed('Error');
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(wrapper(DailyCartoonScreen()));
      expect(find.byKey(dailyCartoonFailedKey), findsOneWidget);
    });

    testWidgets('logs out when logout button is tapped', (tester) async {
      var state = DailyCartoonFailed('Error');
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(wrapper(DailyCartoonScreen()));
      await tester.tap(find.byKey(dailyCartoonLogoutButtonKey));
      verify(() => authenticationBloc.add(Logout()));
    });
  });
}
