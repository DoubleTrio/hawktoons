import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/bloc/authentication_event.dart';

void main() {
  group('AuthenicationEvent', () {
    group('AppStarted', () {
      test('supports value comparisons', () {
        expect(
          AppStarted(),
          AppStarted(),
        );
        expect(
          AppStarted().toString(),
          AppStarted().toString(),
        );
      });
    });
  });
}
