import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/app/app.dart';
import 'package:history_app/auth/auth.dart';

import 'helpers/helpers.dart';

void main() {
  group('App', () {
    setupCloudFirestoreMocks();
    setUpAll(() async {
      await setUpHydratedDirectory();
      await Firebase.initializeApp();
    });

    testWidgets('renders LoginScreen', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
