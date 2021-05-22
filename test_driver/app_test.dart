import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

final pageView = find.byType('PageView');
final filterPopUp = find.byType('FilterPopUp');

final nextPageOnboardingButton = find.byValueKey('OnboardingPage_NextPage');
final setSeenOnboardingButton =
  find.byValueKey('OnboardingPage_SetSeenOnboarding');

final loginLoadingIndicator = find.byValueKey('LoginPage_LoggingIn');
final loginError = find.byValueKey('LoginPage_LoginError');
final signInAnonymouslyButton =
  find.byValueKey('LoginPage_SignInAnonymouslyButton');

final dailyCartoonTab = find.byValueKey('TabSelector_DailyTab');
final allCartoonsTab = find.byValueKey('TabSelector_AllTab');
final changeThemeTab = find.byValueKey('TabSelector_ChangeTheme');

final dailyCartoonLogoutButton =
  find.byValueKey('DailyCartoonView_Button_Logout');
final dailyCartoonInProgress =
  find.byValueKey('DailyCartoonView_DailyCartoonInProgress');
final dailyCartoonLoaded =
  find.byValueKey('DailyCartoonView_DailyCartoonLoaded');
final dailyCartoonFailed =
  find.byValueKey('DailyCartoonView_DailyCartoonFailed');

final allCartoonsLoading =
  find.byValueKey('AllCartoonsPage_AllCartoonsLoading');
final allCartoonsLoaded =
  find.byValueKey('AllCartoonsPage_AllCartoonsLoaded');
final allCartoonsFailed =
  find.byValueKey('AllCartoonsPage_AllCartoonsFailed');

final filterButton = find.byValueKey('AllCartoonsPage_FilterButton');
final cartoonLogoutButton = find.byValueKey('AllCartoonsPage_LogoutButton');

final resetFilterButton = find.byValueKey(
    'ButtonRowHeader_ResetButton');
final applyFilterButton = find.byValueKey('ButtonRowHeader_ApplyFilterButton');

final tagButton = find.byValueKey('Tag_Button_6');
final sortByTile = find.byValueKey('SortByMode_Button_1');
final imageTypeButton = find.byValueKey('ImageTypeCheckbox_1_Checkbox');

final cartoonCard = find.byValueKey('CartoonCard_LN7FeDDb6NaS4PUphgRd');
final detailsView = find.byType('DetailsView');
final detailsPageBackButton = find.byValueKey('DetailsPage_BackButton');

void main() {
  group('Hawktoons integration test', () {
    late FlutterDriver driver;

    setUp(() async {
      driver = await FlutterDriver.connect();
    });
    
    tearDown(() async {
      await driver.close();
    });

    test('completes onboarding flow', () async {
      sleep(const Duration(seconds: 1));
      await driver.scroll(
        pageView,
        -400,
        0,
        const Duration(milliseconds: 500)
      );

      await driver.scroll(
        pageView,
        -400,
        0,
        const Duration(milliseconds: 500)
      );

      await driver.scroll(
        pageView,
        400,
        0,
        const Duration(milliseconds: 500)
      );

      await driver.scroll(
        pageView,
        400,
        0,
        const Duration(milliseconds: 500)
      );

      await driver.tap(nextPageOnboardingButton);
      await driver.tap(setSeenOnboardingButton);

      await driver.waitFor(dailyCartoonLoaded);
    });


    test('complete login flow', () async {
      await driver.runUnsynchronized(() =>
          driver.tap(signInAnonymouslyButton)
      );
      expect(loginLoadingIndicator, isNotNull);
    });

    test('completes home flow', () async {
      await driver.runUnsynchronized(() =>
          driver.tap(changeThemeTab)
      );

      await driver.tap(allCartoonsTab);
      await driver.waitFor(allCartoonsLoaded);

      await driver.tap(filterButton);

      await driver.waitFor(filterPopUp);

      sleep(const Duration(seconds: 1));

      await driver.waitFor(tagButton);
      await driver.tap(tagButton);

      await driver.waitFor(imageTypeButton);
      await driver.tap(imageTypeButton);

      await driver.scroll(
        filterPopUp,
        0,
        -200,
        const Duration(milliseconds: 500),
      );
      await driver.tap(sortByTile);
      await driver.tap(applyFilterButton);
      await driver.waitFor(allCartoonsLoaded);
      await driver.tap(cartoonCard);
      await driver.waitFor(detailsView);
      sleep(const Duration(seconds: 1));
      await driver.tap(detailsPageBackButton);
      expect(allCartoonsLoaded, isNotNull);
      await driver.tap(changeThemeTab);
      await driver.tap(filterButton);
      await driver.waitFor(filterPopUp);
      sleep(const Duration(seconds: 1));
      await driver.tap(resetFilterButton);
      await driver.tap(applyFilterButton);
      await driver.waitFor(allCartoonsLoaded);
      sleep(const Duration(milliseconds: 500));
      await driver.tap(dailyCartoonTab);
      await driver.tap(dailyCartoonLogoutButton);
      sleep(const Duration(milliseconds: 500));
    });
  });
}
