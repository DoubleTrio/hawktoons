import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/onboarding/onboarding.dart';

import '../../helpers/helpers.dart';

void main() {
  setUp(initHydratedBloc);

  group('OnboardingSeenCubit', () {
    test('initial state is false', () {
      expect(OnboardingSeenCubit().state, equals(false));
    });

    test('toJson and fromJson works', () {
      final seenCubit = OnboardingSeenCubit();
      expect(seenCubit.fromJson(seenCubit.toJson(false)), false);
    });

    blocTest<OnboardingSeenCubit, bool>(
      'emits [true] when onboarding is seen',
      build: () => OnboardingSeenCubit(),
      act: (cubit) => cubit.setSeenOnboarding(),
      expect: () => [true],
    );
  });
}
