import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/onboarding/onboarding.dart';

void main() {
  group('OnboardingPageCubit', () {
    test('initial state is VisibleOnboardingPage.welcome', () {
      expect(
        OnboardingPageCubit().state,
        equals(VisibleOnboardingPage.welcome)
      );
    });

    blocTest<OnboardingPageCubit, VisibleOnboardingPage>(
      'emits [VisibleOnboardingPage.dailyCartoon] when selectSortBy is invoked',
      build: () => OnboardingPageCubit(),
      act: (cubit) => cubit.setOnBoardingPage(
        VisibleOnboardingPage.dailyCartoon
      ),
      expect: () => [VisibleOnboardingPage.dailyCartoon],
    );

    blocTest<OnboardingPageCubit, VisibleOnboardingPage>(
      'emits correct pages when selectSortBy is invoked 3 times',
      build: () => OnboardingPageCubit(),
      act: (cubit) => cubit
        ..setOnBoardingPage(VisibleOnboardingPage.dailyCartoon)
        ..setOnBoardingPage(VisibleOnboardingPage.allCartoons)
        ..setOnBoardingPage(VisibleOnboardingPage.welcome),
      expect: () => [
        VisibleOnboardingPage.dailyCartoon,
        VisibleOnboardingPage.allCartoons,
        VisibleOnboardingPage.welcome
      ],
    );
  });
}
