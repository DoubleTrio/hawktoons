import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/auth/bloc/auth.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('OnboardingFlow', () {
    late AuthenticationBloc authenticationBloc;
    late OnboardingCubit onboardingCubit;

    setUpAll(() {
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<OnboardingState>(FakeOnboardingState());
    });

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      onboardingCubit = MockOnboardingCubit();
    });

    testWidgets('screen is OnboardingView', (tester) async {
      when(() => onboardingCubit.state).thenReturn(
        const OnboardingState.initial()
      );
      await tester.pumpApp(
        const OnboardingFlow(),
        onboardingCubit: onboardingCubit,
      );
      expect(find.byType(OnboardingView), findsOneWidget);
    });

    testWidgets('screen is AuthFlow', (tester) async {
      when(() => onboardingCubit.state).thenReturn(const OnboardingState(
        seenOnboarding: true,
        onboardingPage: VisibleOnboardingPage.welcome,
      ));
      when(() => authenticationBloc.state).thenReturn(
        const AuthenticationState.uninitialized()
      );
      await tester.pumpApp(
        const OnboardingFlow(),
        authenticationBloc: authenticationBloc,
        onboardingCubit: onboardingCubit,
      );
      expect(find.byType(AuthFlow), findsOneWidget);
    });
  });
}
