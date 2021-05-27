// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/auth/bloc/auth.dart';

void main() {
  group('AuthenticationEvent', () {
    group('SignInAnonymously', () {
      test('supports value comparisons', () {
        expect(
          SignInAnonymously(),
          SignInAnonymously(),
        );
        expect(
          SignInAnonymously().toString(),
          SignInAnonymously().toString(),
        );
      });
    });

    group('SignInWithGoogle', () {
      test('supports value comparisons', () {
        expect(
          SignInWithGoogle(),
          SignInWithGoogle(),
        );
        expect(
          SignInWithGoogle().toString(),
          SignInWithGoogle().toString(),
        );
      });
    });

    group('Logout', () {
      test('supports value comparisons', () {
        expect(
          Logout(),
          Logout(),
        );
        expect(
          Logout().toString(),
          Logout().toString(),
        );
      });
    });
  });
}
