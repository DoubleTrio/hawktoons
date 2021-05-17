import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
// import 'package:integration_test/integration_test.dart';
import 'package:test/test.dart';

void main() {
  group('Hawktoons App', () {
    late FlutterDriver driver;

    var pv = find.byType('PageView');
    var nextPageOnboardingButton =
      find.byValueKey('OnboardingPage_NextPage');
    var setSeenOnboardingButton =
      find.byValueKey('OnboardingPage_SetSeenOnboarding');
    var loginAnonymouslyButton = find.byValueKey(
      'LoginPage_SignInAnonymouslyButton'
    );
    var loggingInLoadingIndicator = find.byValueKey('LoginPage_LoggingIn');
    var allCartoonsTabButton = find.byValueKey('TabSelector_AllTab');
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    
    tearDownAll(() async {
      await driver.close();
    });

    test('onboarding page', () async {
      sleep(const Duration(seconds: 2));
      await driver.scroll(
        pv,
        -400,
        0,
        const Duration(milliseconds: 500)
      );

      await driver.scroll(
        pv,
        -400,
        0,
        const Duration(milliseconds: 500)
      );

      await driver.scroll(
        pv,
        400,
        0,
        const Duration(milliseconds: 500)
      );

      await driver.scroll(
        pv,
        400,
        0,
        const Duration(milliseconds: 500)
      );

      await driver.tap(nextPageOnboardingButton);
      await driver.tap(setSeenOnboardingButton);

      await driver.runUnsynchronized(() =>
        driver.tap(loginAnonymouslyButton)
      );

      expect(loggingInLoadingIndicator, isNotNull);

      await driver.tap(allCartoonsTabButton);
    });
  });
}
