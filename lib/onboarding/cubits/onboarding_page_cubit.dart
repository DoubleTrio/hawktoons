import 'package:history_app/onboarding/onboarding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class OnboardingPageCubit extends Cubit<VisableOnboardingPage> {
  OnboardingPageCubit() : super(VisableOnboardingPage.welcome);

  void setOnBoardingPage(VisableOnboardingPage page) {
    return emit(page);
  }
}
