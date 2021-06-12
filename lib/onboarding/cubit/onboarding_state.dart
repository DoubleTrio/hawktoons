import 'package:equatable/equatable.dart';
import 'package:hawktoons/onboarding/onboarding.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    required this.seenOnboarding,
    required this.onboardingPage
  });

  const OnboardingState.initial() : this(
    seenOnboarding: false,
    onboardingPage: VisibleOnboardingPage.welcome,
  );

  final bool seenOnboarding;
  final VisibleOnboardingPage onboardingPage;

  OnboardingState copyWith({
    bool? seenOnboarding,
    VisibleOnboardingPage? onboardingPage,
  }) {
    return OnboardingState(
      seenOnboarding: seenOnboarding ?? this.seenOnboarding,
      onboardingPage: onboardingPage ?? this.onboardingPage,
    );
  }

  @override
  List<Object?> get props => [seenOnboarding, onboardingPage];
}