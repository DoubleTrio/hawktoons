import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/onboarding/onboarding.dart';

void main() {
  group('OnboardingPageCubit', () {
    test('initial state is VisibleOnboardingPage.welcome', () {
      expect(
        OnboardingPageCubit().state,
        equals(VisibleOnboardingPage.welcome)
      );
    });

    blocTest<OnboardingPageCubit, VisibleOnboardingPage>(
      'emits [VisibleOnboardingPage.latestCartoon] '
      'when selectSortBy is invoked',
      build: () => OnboardingPageCubit(),
      act: (cubit) =>
        cubit.setOnboardingPage(VisibleOnboardingPage.latestCartoon),
      expect: () => [VisibleOnboardingPage.latestCartoon],
    );

    blocTest<OnboardingPageCubit, VisibleOnboardingPage>(
      'emits correct pages when selectSortBy is invoked 3 times',
      build: () => OnboardingPageCubit(),
      act: (cubit) => cubit
        ..setOnboardingPage(VisibleOnboardingPage.latestCartoon)
        ..setOnboardingPage(VisibleOnboardingPage.allCartoons)
        ..setOnboardingPage(VisibleOnboardingPage.welcome),
      expect: () => [
        VisibleOnboardingPage.latestCartoon,
        VisibleOnboardingPage.allCartoons,
        VisibleOnboardingPage.welcome
      ],
    );
  });
}
