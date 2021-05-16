import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';
import '../../mocks.dart';

const _loggingInKey = Key('LoginPage_LoggingIn');
const _unauthenticatedKey = Key('LoginPage_LoginError');
const _signInAnonymouslyButtonKey = Key('LoginPage_SignInAnonymouslyButton');

void main() {
  group('LoginPage', () {
    setupCloudFirestoreMocks();
    late AuthenticationBloc authenticationBloc;

    Widget wrapper(Widget child) {
      return BlocProvider.value(value: authenticationBloc, child: child);
    }

    setUpAll(() async {
      registerFallbackValue<AuthenticationState>(Uninitialized());
      registerFallbackValue<AuthenticationEvent>(SignInAnonymously());
      await Firebase.initializeApp();
      authenticationBloc = MockAuthenticationBloc();
    });


    testWidgets(
      'AuthenticationBloc adds SignInAnonymously '
      'when sign in button is tapped', (tester) async {
      when(() => authenticationBloc.state).thenReturn(Uninitialized());
      await tester.pumpApp(
        wrapper(const LoginScreen()),
      );
      await tester.tap(find.byKey(_signInAnonymouslyButtonKey));
      verify(() => authenticationBloc.add(SignInAnonymously())).called(1);
    });

    testWidgets(
      'finds Key(\'LoginPage_LoggingIn\') '
      'when state is LoggingIn', (tester) async {
      var state = LoggingIn();
      when(() => authenticationBloc.state).thenReturn(state);
      await tester.pumpApp(
        wrapper(const LoginScreen()),
      );
      expect(find.byKey(_loggingInKey), findsOneWidget);
    });

    testWidgets(
      'finds Key(\'LoginPage_LoginError\') '
      'when state is LoginError', (tester) async {
      var state = LoginError();
      when(() => authenticationBloc.state).thenReturn(state);
      await tester.pumpApp(
        wrapper(const LoginScreen()),
      );
      expect(find.byKey(_unauthenticatedKey), findsOneWidget);
    });
  });
}
