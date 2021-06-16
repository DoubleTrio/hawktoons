import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/app/app.dart';
import 'package:hawktoons/onboarding/flow/onboarding_flow.dart';
import 'helpers/helpers.dart';

void main() {
  group('App', () {
    setupCloudFirestoreMocks();
    setupFirebaseStorageMocks();

    setUpAll(() async {
      initHydratedBloc();
      await Firebase.initializeApp();
    });

    testWidgets('renders OnboardingFlow', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OnboardingFlow), findsOneWidget);
    });
  });
}
