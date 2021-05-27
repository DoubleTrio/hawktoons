import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/onboarding/onboarding.dart';

class OnboardingFlow extends StatelessWidget {
  const OnboardingFlow({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlowBuilder<bool>(
      state: context.watch<OnboardingSeenCubit>().state,
      onGeneratePages: (onboardingSeen, context) {
        return [
          onboardingSeen ? const AuthFlowPage() : const OnBoardingPage()
        ];
      }
    );
  }
}
