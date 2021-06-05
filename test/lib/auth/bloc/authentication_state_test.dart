// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/auth/bloc/authentication_state.dart';

import '../../fakes.dart';

void main() {
  group('AuthenticationState', () {
    final mockUser = FakeUser();
    group('uninitialized', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationState.uninitialized(),
          AuthenticationState.uninitialized(),
        );
      });
    });

    group('authenticated', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationState.authenticated(mockUser),
          AuthenticationState.authenticated(mockUser),
        );
      });
    });

    group('loginError', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationState.loginError(),
          AuthenticationState.loginError(),
        );
      });
    });

    group('loggingIn', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationState.loggingIn(),
          AuthenticationState.loggingIn(),
        );
      });
    });

    group('loggingOut', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationState.loggingOut(mockUser),
          AuthenticationState.loggingOut(mockUser),
        );
      });
    });

    group('logoutError', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationState.logoutError(),
          AuthenticationState.logoutError(),
        );
      });
    });

    group('logoutUninitialized', () {
      test('supports value comparisons', () {
        expect(
          AuthenticationState.logoutUninitialized(mockUser),
          AuthenticationState.logoutUninitialized(mockUser),
        );
      });
    });
  });
}
