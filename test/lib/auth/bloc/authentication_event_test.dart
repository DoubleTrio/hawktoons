import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/bloc/auth.dart';

void main() {
  group('AuthenicationEvent', () {
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
