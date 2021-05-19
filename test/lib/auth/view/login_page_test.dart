import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

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
      await tester.tap(find.byKey(signInAnonymouslyButtonKey));
      verify(() => authenticationBloc.add(SignInAnonymously())).called(1);
    });

    testWidgets(
      'finds Key(\'LoginPage_LoggingIn\') '
      'when state is LoggingIn', (tester) async {
      when(() => authenticationBloc.state).thenReturn(LoggingIn());
      await tester.pumpApp(
        wrapper(const LoginScreen()),
      );
      expect(find.byKey(loggingInKey), findsOneWidget);
    });

    testWidgets(
      'finds Key(\'LoginPage_LoginError\') '
      'when state is LoginError', (tester) async {
      when(() => authenticationBloc.state).thenReturn(LoginError());
      await tester.pumpApp(
        wrapper(const LoginScreen()),
      );
      expect(find.byKey(unauthenticatedKey), findsOneWidget);
    });
  });
}
