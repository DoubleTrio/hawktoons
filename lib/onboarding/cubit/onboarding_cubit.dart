import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class OnboardingCubit extends HydratedCubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState.initial());

  void setSeenOnboarding() {
    return emit(state.copyWith(seenOnboarding: true));
  }

  void setOnboardingPage(VisibleOnboardingPage page) {
    return emit(state.copyWith(onboardingPage: page));
  }

  @override
  OnboardingState fromJson(Map<String, dynamic> json) {
    final seenOnboarding = json['seenOnboarding'] as bool;
    return OnboardingState(
      seenOnboarding: seenOnboarding,
      onboardingPage: VisibleOnboardingPage.welcome,
    );
  }

  @override
  Map<String, dynamic> toJson(OnboardingState state) {
    return <String, bool>{'seenOnboarding': state.seenOnboarding};
  }
}
