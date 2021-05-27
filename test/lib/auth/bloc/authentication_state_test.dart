// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/auth/bloc/authentication_state.dart';

import '../../fakes.dart';

void main() {
  group('AuthenticationState', () {
    group('Uninitialized', () {
      test('supports value comparisons', () {
        expect(
          Uninitialized(),
          Uninitialized(),
        );
        expect(Uninitialized().toString(), Uninitialized().toString());
      });
    });

    group('Authenticated', () {
      final mockUser = FakeUser();
      test('supports value comparisons', () {
        expect(
          Authenticated(mockUser),
          Authenticated(mockUser),
        );
        expect(
          Authenticated(mockUser).toString(),
          Authenticated(mockUser).toString(),
        );
      });
    });

    group('LoginError', () {
      test('supports value comparisons', () {
        expect(
          LoginError(),
          LoginError(),
        );
        expect(
          LoginError().toString(),
          LoginError().toString(),
        );
      });
    });

    group('LoggingIn', () {
      test('supports value comparisons', () {
        expect(
          LoggingIn(),
          LoggingIn(),
        );
        expect(
          LoggingIn().toString(),
          LoggingIn().toString(),
        );
      });
    });

    group('LoggingOut', () {
      test('supports value comparisons', () {
        expect(
          LoggingOut(),
          LoggingOut(),
        );
        expect(
          LoggingOut().toString(),
          LoggingOut().toString(),
        );
      });
    });

    group('LogoutError', () {
      test('supports value comparisons', () {
        expect(
          LogoutError(),
          LogoutError(),
        );
        expect(
          LogoutError().toString(),
          LogoutError().toString(),
        );
      });
    });
  });
}
