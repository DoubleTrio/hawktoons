import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('LoginPage', () {
    late AuthenticationBloc authenticationBloc;

    Widget wrapper(Widget child) {
      return BlocProvider.value(value: authenticationBloc, child: child);
    }

    setUpAll(() {
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    });

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
    });

    group('semantics', () {
      testWidgets('passes semantics for light theme', (tester) async {
        when(() => authenticationBloc.state).thenReturn(const Uninitialized());
        await tester.pumpApp(
          wrapper(const LoginView()),
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes semantics for dark theme', (tester) async {
        when(() => authenticationBloc.state).thenReturn(const Uninitialized());
        await tester.pumpApp(
          wrapper(const LoginView()),
          mode: ThemeMode.dark,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets(
      'AuthenticationBloc adds SignInAnonymously '
      'when sign in button is tapped', (tester) async {
      when(() => authenticationBloc.state).thenReturn(const Uninitialized());
      await tester.pumpApp(
        wrapper(const LoginView()),
      );
      await tester.tap(find.byKey(signInAnonymouslyButtonKey));
      verify(() => authenticationBloc.add(const SignInAnonymously())).called(1);
    });

    testWidgets(
      'finds Key(\'LoginPage_LoggingIn\') '
      'when state is LoggingIn', (tester) async {
      when(() => authenticationBloc.state).thenReturn(const LoggingIn());
      await tester.pumpApp(
        wrapper(const LoginView()),
      );
      expect(find.byKey(loggingInKey), findsOneWidget);
    });

    testWidgets(
      'finds Key(\'LoginPage_LoginError\') '
      'when state is LoginError', (tester) async {
      when(() => authenticationBloc.state).thenReturn(const LoginError());
      await tester.pumpApp(
        wrapper(const LoginView()),
      );
      expect(find.byKey(unauthenticatedKey), findsOneWidget);
    });
  });
}
