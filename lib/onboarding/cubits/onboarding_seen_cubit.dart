import 'package:hydrated_bloc/hydrated_bloc.dart';

// class OnboardingSeenCubit extends HydratedCubit<bool> {
//   OnboardingSeenCubit() : super(false);
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

class OnboardingSeenCubit extends Cubit<bool> {
  OnboardingSeenCubit() : super(false);

  void setSeenOnboarding() {
    return emit(true);
  }
}
