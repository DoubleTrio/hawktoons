import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/onboarding/onboarding.dart';

void main() {
  group('OnboardingPageCubit', () {
    test('initial state is VisableOnboardingPage.welcome', () {
      expect(
        OnboardingPageCubit().state,
        equals(VisableOnboardingPage.welcome)
      );
    });

    blocTest<OnboardingPageCubit, VisableOnboardingPage>(
      'emits [VisableOnboardingPage.dailyCartoon] when selectSortBy is invoked',
      build: () => OnboardingPageCubit(),
      act: (cubit) => cubit.setOnBoardingPage(
        VisableOnboardingPage.dailyCartoon
      ),
      expect: () => [VisableOnboardingPage.dailyCartoon],
    );

    blocTest<OnboardingPageCubit, VisableOnboardingPage>(
      'emits correct pages when selectSortBy is invoked 3 times',
      build: () => OnboardingPageCubit(),
      act: (cubit) => cubit
        ..setOnBoardingPage(VisableOnboardingPage.dailyCartoon)
        ..setOnBoardingPage(VisableOnboardingPage.allCartoons)
        ..setOnBoardingPage(VisableOnboardingPage.welcome),
      expect: () => [
        VisableOnboardingPage.dailyCartoon,
        VisableOnboardingPage.allCartoons,
        VisableOnboardingPage.welcome
      ],
    );
  });
}
