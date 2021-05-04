import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/app/app.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';

import 'helpers/helpers.dart';

void main() {
  group('App', () {
    setupCloudFirestoreMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('renders AuthBlocBuilder', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(DailyCartoonScreen), findsOneWidget);
    });
  });
}
