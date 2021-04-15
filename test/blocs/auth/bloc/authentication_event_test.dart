import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/auth/bloc/authentication_event.dart';

void main() {
  group('AuthenicationEvent', () {
    group('StartApp', () {
      test('supports value comparisons', () {
        expect(
          StartApp(),
          StartApp(),
        );
        expect(
          StartApp().toString(),
          StartApp().toString(),
        );
      });
    });
  });
}
