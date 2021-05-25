import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:history_app/onboarding/onboarding.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  group('OnboardingFlow', () {
    late AuthenticationBloc authenticationBloc;
    late OnboardingSeenCubit onboardingSeenCubit;

    setUpAll(() {
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
    });

    setUp(() {
      authenticationBloc = MockAuthenticationBloc();
      onboardingSeenCubit = MockOnboardingSeenCubit();
    });

    testWidgets('screen is OnboardingView', (tester) async {
      when(() => onboardingSeenCubit.state).thenReturn(false);
      await tester.pumpApp(
        const OnboardingFlow(),
        onboardingSeenCubit: onboardingSeenCubit,
      );
      expect(find.byType(OnboardingView), findsOneWidget);
    });

    testWidgets('screen is AuthFlow', (tester) async {
      when(() => onboardingSeenCubit.state).thenReturn(true);
      when(() => authenticationBloc.state).thenReturn(const Uninitialized());
      await tester.pumpApp(
        const OnboardingFlow(),
        authenticationBloc: authenticationBloc,
        onboardingSeenCubit: onboardingSeenCubit,
      );
      expect(find.byType(AuthFlow), findsOneWidget);
    });
  });
}
