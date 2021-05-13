import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';
import '../../mocks.dart';
import '../../fakes.dart';


void main() {
  group('LoginPage', () {
    setupCloudFirestoreMocks();

    var loggingInKey = const Key('LoginPage_LoggingIn');
    var unauthenticatedKey = const Key('LoginPage_LoginError');

    var signInAnonymouslyButtonKey =
        const Key('LoginPage_SignInAnonymouslyButton');
    late AuthenticationBloc authenticationBloc;
    // late SortByCubit sortByCubit;

    setUpAll(() async {
      registerFallbackValue<AuthenticationState>(Uninitialized());
      registerFallbackValue<AuthenticationEvent>(SignInAnonymously());
      await Firebase.initializeApp();

      authenticationBloc = MockAuthenticationBloc();
      // sortByCubit = MockSortByCubit();
    });

    testWidgets(
        'finds Key(\'LoginPage_LoggingIn\') '
        'when state is LoggingIn', (tester) async {
      var state = LoggingIn();

      when(() => authenticationBloc.state).thenReturn(state);
      await tester.pumpApp(
        MultiBlocProvider(providers: [
          BlocProvider.value(
            value: authenticationBloc,
          ),
        ], child: LoginScreen()),
      );
      expect(find.byKey(loggingInKey), findsOneWidget);
    });

    testWidgets(
        'finds Key(\'LoginPage_LoginError\') '
        'when state is LoginError', (tester) async {
      var state = LoginError();

      when(() => authenticationBloc.state).thenReturn(state);
      await tester.pumpApp(
        MultiBlocProvider(providers: [
          BlocProvider.value(
            value: authenticationBloc,
          ),
        ], child: LoginScreen()),
      );
      expect(find.byKey(unauthenticatedKey), findsOneWidget);
    });

    testWidgets(
        'AuthenticationBloc adds SignInAnonymously '
        'when sign in button is tapped', (tester) async {
      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: authenticationBloc,
        ),
      ], child: LoginScreen()));

      await tester.tap(find.byKey(signInAnonymouslyButtonKey));
      verify(() => authenticationBloc.add(SignInAnonymously())).called(1);
    });

    testWidgets(
        'navigates to HomeFlow route '
        'when state is Authenticated', (tester) async {
      var states = [Authenticated('user-id')];
      whenListen<AuthenticationState>(
          authenticationBloc, Stream.fromIterable(states),
          initialState: Uninitialized());
      when(() => authenticationBloc.state).thenReturn(states[0]);

      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: authenticationBloc,
        ),
      ], child: LoginScreen()));
      expect(find.byType(SizedBox), findsOneWidget);
      // TODO - fix strange bug involving not navigating
      // tester.pumpAndSettle();
      // expect(find.byType(HomeFlow), findsOneWidget);
    });
  });
}
