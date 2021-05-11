import 'package:hydrated_bloc/hydrated_bloc.dart';

// class OnboardingCubit extends HydratedCubit<bool> {
//   OnboardingCubit() : super(false);
//
//   void setSeenOnboarding() {
//     return emit(true);
//   }
//
//   @override
//   bool fromJson(Map<String, dynamic> json) {
//     return json['seenOnboarding'] as bool;
//   }
//
//   @override
//   Map<String, dynamic> toJson(bool state) {
//     return <String, bool>{'seenOnboarding': state};
//   }
// }

class OnboardingCubit extends Cubit<bool> {
  OnboardingCubit() : super(false);

  void setSeenOnboarding() {
    return emit(true);
  }
}
