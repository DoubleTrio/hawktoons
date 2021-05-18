import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/onboarding/onboarding.dart';

void main() {
  group('OnboardingSeenCubit', () {
    test('initial state is false', () {
      expect(OnboardingSeenCubit().state, equals(false));
    });

    blocTest<OnboardingSeenCubit, bool>(
      'emits [true] when onboarding is seen',
      build: () => OnboardingSeenCubit(),
      act: (cubit) => cubit.setSeenOnboarding(),
      expect: () => [true],
    );
  });
}
