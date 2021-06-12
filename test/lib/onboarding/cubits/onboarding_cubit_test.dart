import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/onboarding/onboarding.dart';

import '../../helpers/helpers.dart';

void main() {
  setUp(initHydratedBloc);

  group('OnboardingCubit', () {
    test('initial state is OnboardingState.initial', () {
      expect(
        OnboardingCubit().state,
        const OnboardingState.initial(),
      );
    });

    test('toJson and fromJson works', () {
      final onboardingCubit = OnboardingCubit();
      final state = const OnboardingState.initial();
      expect(
        onboardingCubit.fromJson(onboardingCubit.toJson(state)),
        state,
      );
    });

    blocTest<OnboardingCubit, OnboardingState>(
      'emits correct page state'
      'when setOnboardingPage is invoked',
      build: () => OnboardingCubit(),
      act: (cubit) =>
        cubit.setOnboardingPage(VisibleOnboardingPage.latestCartoon),
      expect: () => [
        const OnboardingState(
          seenOnboarding: false,
          onboardingPage: VisibleOnboardingPage.latestCartoon
        ),
      ],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'emits correct seenOnboarding state'
      'when setSeenOnboarding is invoked',
      build: () => OnboardingCubit(),
      act: (cubit) => cubit.setSeenOnboarding(),
      expect: () => [
        const OnboardingState(
          seenOnboarding: true,
          onboardingPage: VisibleOnboardingPage.welcome,
        ),
      ],
    );
  });
}