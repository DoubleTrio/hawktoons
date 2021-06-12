import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/onboarding/onboarding.dart';

class OnboardingFlow extends StatelessWidget {
  const OnboardingFlow({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final seenOnboarding = context.select<OnboardingCubit, bool>(
      (cubit) => cubit.state.seenOnboarding
    );
    return FlowBuilder<bool>(
      state: seenOnboarding,
      onGeneratePages: (onboardingSeen, context) {
        return [
          onboardingSeen ? const AuthFlowPage() : const OnboardingPage()
        ];
      }
    );
  }
}
