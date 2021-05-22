// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/bloc/authentication_state.dart';

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
      final userId = 'user-id';
      test('supports value comparisons', () {
        expect(
          Authenticated(userId),
          Authenticated(userId),
        );
        expect(
          Authenticated(userId).toString(),
          Authenticated(userId).toString(),
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
