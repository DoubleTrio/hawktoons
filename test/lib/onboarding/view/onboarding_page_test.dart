import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('OnboardingPage', () {
    late OnboardingPageCubit onboardingPageCubit;
    late OnboardingSeenCubit onboardingSeenCubit;

    setUpAll(() {
      registerFallbackValue<VisibleOnboardingPage>(
        VisibleOnboardingPage.welcome
      );
    });

    setUp(() {
      onboardingPageCubit = MockOnboardingPageCubit();
      onboardingSeenCubit = MockOnboardingSeenCubit();

      when(() => onboardingSeenCubit.state).thenReturn(false);
      when(() => onboardingPageCubit.state)
        .thenReturn(VisibleOnboardingPage.welcome);
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const OnboardingView(),
          onboardingPageCubit: onboardingPageCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const OnboardingView(),
          onboardingPageCubit: onboardingPageCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('setOnboarding page called twice when swiped', (tester) async {
      await tester.pumpApp(
        const OnboardingView(),
        onboardingPageCubit: onboardingPageCubit,
      );
      await tester.drag(find.byType(OnboardingWidget), const Offset(-1000, 0));
      await tester.drag(find.byType(OnboardingWidget), const Offset(-1000, 0));
      await tester.drag(find.byType(OnboardingWidget), const Offset(1000, 0));

      verifyInOrder([
        () => onboardingPageCubit
          .setOnboardingPage(VisibleOnboardingPage.latestCartoon),
        () => onboardingPageCubit
          .setOnboardingPage(VisibleOnboardingPage.allCartoons),
        () => onboardingPageCubit
          .setOnboardingPage(VisibleOnboardingPage.latestCartoon),
      ]);
    });

    testWidgets(
      'setOnboarding page called twice '
      'when next button is tapped', (tester) async {
      await tester.pumpApp(
        const OnboardingView(),
        onboardingPageCubit: onboardingPageCubit,
      );

      await tester.tap(find.byKey(nextPageOnboardingButtonKey));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(nextPageOnboardingButtonKey));
      await tester.pumpAndSettle();

      verifyInOrder([
        () => onboardingPageCubit
          .setOnboardingPage(VisibleOnboardingPage.latestCartoon),
        () => onboardingPageCubit
          .setOnboardingPage(VisibleOnboardingPage.allCartoons),
      ]);
    });

    testWidgets(
      'completes onboarding '
      'when start button is tapped', (tester) async {
      when(() => onboardingPageCubit.state)
        .thenReturn(VisibleOnboardingPage.allCartoons);

      await tester.pumpApp(
        const OnboardingView(),
        onboardingPageCubit: onboardingPageCubit,
        onboardingSeenCubit: onboardingSeenCubit,
      );
      expect(find.text('Start'), findsOneWidget);
      await tester.tap(find.byKey(startCompleteOnboardingButtonKey));
      await tester.pumpAndSettle();
      
      verify(onboardingSeenCubit.setSeenOnboarding).called(1);
    });

    testWidgets(
      'completes onboarding '
      'when skip button is tapped', (tester) async {
      when(() => onboardingPageCubit.state)
        .thenReturn(VisibleOnboardingPage.latestCartoon);

      await tester.pumpApp(
        const OnboardingView(),
        onboardingPageCubit: onboardingPageCubit,
        onboardingSeenCubit: onboardingSeenCubit,
      );
      await tester.tap(find.byKey(setSeenOnboardingButtonKey));
      await tester.pumpAndSettle();

      verify(onboardingSeenCubit.setSeenOnboarding).called(1);
    });
  });
}
