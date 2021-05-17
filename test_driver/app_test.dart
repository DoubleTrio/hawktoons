import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


final dailyCartoonTab = find.byValueKey('TabSelector_DailyTab');
final allCartoonsTab = find.byValueKey('TabSelector_AllTab');
final changeThemeTab = find.byValueKey('TabSelector_ChangeTheme');
final detailsPageBackButton = find.byValueKey('DetailsPage_BackButton');

final dailyCartoonInProgress =
  find.byValueKey('DailyCartoonScreen_DailyCartoonInProgress');

final dailyCartoonLoaded =
  find.byValueKey('DailyCartoonScreen_DailyCartoonLoaded');

final dailyCartoonFailed =
  find.byValueKey('DailyCartoonScreen_DailyCartoonFailed');

final dailyCartoonLogoutButton =
  find.byValueKey('DailyCartoonScreen_Button_Logout');

final nextPageOnboardingButton = find.byValueKey('OnboardingPage_NextPage');
final setSeenOnboardingButton =
  find.byValueKey('OnboardingPage_SetSeenOnboarding');

final filteredCartoonsLoading =
  find.byValueKey('FilteredCartoonsPage_FilteredCartoonsLoading');
final filteredCartoonsLoaded =
  find.byValueKey('FilteredCartoonsPage_FilteredCartoonsLoaded');
final filteredCartoonsFailed =
  find.byValueKey('FilteredCartoonsPage_FilteredCartoonsFailed');
final filterButton = find.byValueKey('FilteredCartoonsPage_FilterButton');
final filterLogoutButton = find.byValueKey('FilteredCartoonsPage_LogoutButton');

final loginLoadingIndicator = find.byValueKey('LoginPage_LoggingIn');
final loginError = find.byValueKey('LoginPage_LoginError');
final signInAnonymouslyButton =
  find.byValueKey('LoginPage_SignInAnonymouslyButton');

final resetFilterButton = find.byValueKey('ButtonRowHeader_ResetButton');
final applyFilterButton = find.byValueKey('ButtonRowHeader_ApplyFilterButton');

final tagButton = find.byValueKey('Tag_Button_6');
final sortByTile = find.byValueKey('SortByMode_Button_1');
final imageTypeButton = find.byValueKey('ImageTypeCheckbox_1_Checkbox');


final pageView = find.byType('PageView');

void main() {
  group('Hawktoons integration test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    
    tearDownAll(() async {
      await driver.close();
    });

    test('onboarding page', () async {
      sleep(const Duration(seconds: 2));
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

      await driver.runUnsynchronized(() =>
        driver.tap(signInAnonymouslyButton)
      );

      expect(loginLoadingIndicator, isNotNull);


      await driver.waitFor(dailyCartoonLoaded);

      await driver.runUnsynchronized(() =>
        driver.tap(changeThemeTab)
      );

      await driver.tap(allCartoonsTab);
      await driver.waitFor(filteredCartoonsLoaded);

      await driver.tap(filterButton);
      
      await driver.waitFor(find.byType('FilterPopUp'));

      sleep(const Duration(seconds: 2));

      await driver.waitFor(tagButton);
      await driver.tap(tagButton);

      await driver.waitFor(imageTypeButton);
      await driver.tap(imageTypeButton);

      await driver.scroll(
        find.byType('FilterPopUp'),
        0,
        -200,
        const Duration(milliseconds: 500)
      );

      await driver.tap(sortByTile);
      await driver.tap(applyFilterButton);
      await driver.waitFor(filteredCartoonsLoaded);

      await driver.tap(find.byValueKey('CartoonCard_LN7FeDDb6NaS4PUphgRd'));

      await driver.waitFor(find.byType('DetailsScreen'));
      sleep(const Duration(seconds: 2));
      await driver.tap(detailsPageBackButton);
      expect(filteredCartoonsLoaded, isNotNull);
      await driver.tap(changeThemeTab);

      await driver.tap(filterButton);
      await driver.waitFor(find.byType('FilterPopUp'));

      sleep(const Duration(seconds: 2));

      await driver.tap(resetFilterButton);
      await driver.tap(applyFilterButton);
      await driver.waitFor(filteredCartoonsLoaded);
      sleep(const Duration(milliseconds: 500));
      await driver.tap(dailyCartoonTab);
      await driver.tap(dailyCartoonLogoutButton);
      sleep(const Duration(milliseconds: 1000));
    });
  });
}
