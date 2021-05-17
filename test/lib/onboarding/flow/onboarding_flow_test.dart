import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:history_app/onboarding/onboarding.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';


void main() {
  group('OnboardingFlow', () {
    late OnboardingSeenCubit onboardingSeenCubit;
    late AuthenticationBloc authenticationBloc;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: onboardingSeenCubit),
        BlocProvider.value(value: authenticationBloc),
      ], child: child);
    }

    setUpAll(() {
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      onboardingSeenCubit = MockOnboardingSeenCubit();
      authenticationBloc = MockAuthenticationBloc();
    });

    testWidgets('screen is OnboardingScreen', (tester) async {
      when(() => onboardingSeenCubit.state).thenReturn(false);
      await tester.pumpApp(wrapper(const OnboardingFlow()));
      expect(find.byType(OnboardingScreen), findsOneWidget);
    });

    testWidgets('screen is AuthFlow', (tester) async {
      when(() => onboardingSeenCubit.state).thenReturn(true);
      when(() => authenticationBloc.state).thenReturn(Uninitialized());
      await tester.pumpApp(wrapper(const OnboardingFlow()));
      expect(find.byType(AuthFlow), findsOneWidget);
    });
  });
}