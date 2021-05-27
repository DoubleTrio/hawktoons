import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class OnboardingPageCubit extends Cubit<VisibleOnboardingPage> {
  OnboardingPageCubit() : super(VisibleOnboardingPage.welcome);

  void setOnBoardingPage(VisibleOnboardingPage page) {
    return emit(page);
  }
}
