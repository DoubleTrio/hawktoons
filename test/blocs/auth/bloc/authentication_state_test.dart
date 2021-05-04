import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/auth/bloc/authentication_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

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
      });
    });

    group('Unauthenticated', () {
      test('supports value comparisons', () {
        expect(
          Unauthenticated(),
          Unauthenticated(),
        );
      });
    });

    group('AuthLoading', () {
      test('supports value comparisons', () {
        expect(
          AuthLoading(),
          AuthLoading(),
        );
      });
    });
  });
}
