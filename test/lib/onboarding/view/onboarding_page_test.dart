import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:mocktail/mocktail.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('OnboardingPage', () {
    late OnboardingCubit onboardingCubit;

    setUpAll(() {
      registerFallbackValue<OnboardingState>(FakeOnboardingState());
    });

    setUp(() {
      onboardingCubit = MockOnboardingCubit();
      when(() => onboardingCubit.state).thenReturn(
        const OnboardingState.initial()
      );
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const OnboardingView(),
          onboardingCubit: onboardingCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const OnboardingView(),
          onboardingCubit: onboardingCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('setOnboarding page called twice when swiped', (tester) async {
      await tester.pumpApp(
        const OnboardingView(),
        onboardingCubit: onboardingCubit,
      );
      await tester.drag(find.byType(OnboardingWidget), const Offset(-1000, 0));
      await tester.drag(find.byType(OnboardingWidget), const Offset(-1000, 0));
      await tester.drag(find.byType(OnboardingWidget), const Offset(1000, 0));

      verifyInOrder([
        () => onboardingCubit
          .setOnboardingPage(VisibleOnboardingPage.latestCartoon),
        () => onboardingCubit
          .setOnboardingPage(VisibleOnboardingPage.allCartoons),
        () => onboardingCubit
          .setOnboardingPage(VisibleOnboardingPage.latestCartoon),
      ]);
    });

    testWidgets(
      'setOnboarding page called twice '
      'when next button is tapped', (tester) async {
      await tester.pumpApp(
        const OnboardingView(),
        onboardingCubit: onboardingCubit,
      );

      await tester.tap(find.byKey(nextPageOnboardingButtonKey));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(nextPageOnboardingButtonKey));
      await tester.pumpAndSettle();

      verifyInOrder([
        () => onboardingCubit
          .setOnboardingPage(VisibleOnboardingPage.latestCartoon),
        () => onboardingCubit
          .setOnboardingPage(VisibleOnboardingPage.allCartoons),
      ]);
    });

    testWidgets(
      'completes onboarding '
      'when start button is tapped', (tester) async {
      when(() => onboardingCubit.state)
        .thenReturn(
          const OnboardingState(
            seenOnboarding: false,
            onboardingPage: VisibleOnboardingPage.allCartoons
          )
      );

      await tester.pumpApp(
        const OnboardingView(),
        onboardingCubit: onboardingCubit,
      );
      expect(find.text('Start'), findsOneWidget);
      await tester.tap(find.byKey(startCompleteOnboardingButtonKey));
      await tester.pumpAndSettle();
      
      verify(onboardingCubit.setSeenOnboarding).called(1);
    });

    testWidgets(
      'completes onboarding '
      'when skip button is tapped', (tester) async {

      await tester.pumpApp(
        const OnboardingView(),
        onboardingCubit: onboardingCubit,
      );
      await tester.tap(find.byKey(setSeenOnboardingButtonKey));
      await tester.pumpAndSettle();

      verify(onboardingCubit.setSeenOnboarding).called(1);
    });
  });
}
