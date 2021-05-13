import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/onboarding/onboarding.dart';

class OnboardingFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlowBuilder<bool>(
      state: context.watch<OnboardingSeenCubit>().state,
      onGeneratePages: (onboardingSeen, context) {
        return [onboardingSeen ? AuthFlowPage() : OnBoardingPage()];
      }
    );
  }
}
