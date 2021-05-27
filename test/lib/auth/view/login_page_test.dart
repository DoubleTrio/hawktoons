import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/auth/bloc/auth.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('LoginPage', () {
    late AuthenticationBloc authenticationBloc;

    setUpAll(() {
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    });

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      when(() => authenticationBloc.state).thenReturn(const Uninitialized());
    });

    group('semantics', () {
      testWidgets('passes semantics for light theme', (tester) async {
        await tester.pumpApp(
          const LoginView(),
          authenticationBloc: authenticationBloc,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes semantics for dark theme', (tester) async {
        await tester.pumpApp(
          const LoginView(),
          mode: ThemeMode.dark,
          authenticationBloc: authenticationBloc,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets(
      'AuthenticationBloc adds SignInAnonymously '
      'when sign in anonymously button is tapped', (tester) async {
      await tester.pumpApp(
        const LoginView(),
        authenticationBloc: authenticationBloc,
      );
      await tester.tap(find.byKey(signInAnonymouslyButtonKey));
      verify(() => authenticationBloc.add(const SignInAnonymously())).called(1);
    });

    testWidgets(
      'AuthenticationBloc adds SignInWithGoogle '
      'when sign in with google button is tapped', (tester) async {
      await tester.pumpApp(
        const LoginView(),
        authenticationBloc: authenticationBloc,
      );
      await tester.tap(find.byKey(signInWithGoogleButtonKey));
      verify(() => authenticationBloc.add(const SignInWithGoogle())).called(1);
    });

    testWidgets(
      'finds Key(\'LoginPage_LoggingIn\') '
      'when state is LoggingIn', (tester) async {
      when(() => authenticationBloc.state).thenReturn(const LoggingIn());
      await tester.pumpApp(
        const LoginView(),
        authenticationBloc: authenticationBloc,
      );
      expect(find.byKey(loggingInKey), findsOneWidget);
    });

    testWidgets(
      'finds Key(\'LoginPage_LoginError\') '
      'when state is LoginError', (tester) async {
      when(() => authenticationBloc.state).thenReturn(const LoginError());
      await tester.pumpApp(
        const LoginView(),
        authenticationBloc: authenticationBloc,
      );
      expect(find.byKey(unauthenticatedKey), findsOneWidget);
    });
  });
}
