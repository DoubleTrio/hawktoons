import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/onboarding/onboarding.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('OnboardingPage', () {
    late OnboardingPageCubit onboardingPageCubit;
    late OnboardingSeenCubit onboardingSeenCubit;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: onboardingPageCubit),
        BlocProvider.value(value: onboardingSeenCubit)
      ], child: child);
    }

    setUpAll(() {
      registerFallbackValue<VisibleOnboardingPage>(
        VisibleOnboardingPage.welcome
      );
      onboardingPageCubit = MockOnboardingPageCubit();
      onboardingSeenCubit = MockOnboardingSeenCubit();
      when(() => onboardingSeenCubit.state).thenReturn(false);
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        when(() => onboardingPageCubit.state)
          .thenReturn(VisibleOnboardingPage.allCartoons);
        await tester.pumpApp(wrapper(const OnboardingView()));
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        when(() => onboardingPageCubit.state)
          .thenReturn(VisibleOnboardingPage.allCartoons);
        await tester.pumpApp(
          wrapper(const OnboardingView()),
          mode: ThemeMode.dark,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets('setOnboarding page called twice when swiped', (tester) async {
      when(() => onboardingPageCubit.state)
        .thenReturn(VisibleOnboardingPage.welcome);

      await tester.pumpApp(wrapper(const OnboardingView()));
      await tester.drag(find.byType(OnboardingWidget), const Offset(-1000, 0));
      await tester.drag(find.byType(OnboardingWidget), const Offset(-1000, 0));
      await tester.drag(find.byType(OnboardingWidget), const Offset(1000, 0));

      verifyInOrder([
        () => onboardingPageCubit
          .setOnBoardingPage(VisibleOnboardingPage.dailyCartoon),
        () => onboardingPageCubit
          .setOnBoardingPage(VisibleOnboardingPage.allCartoons),
        () => onboardingPageCubit
          .setOnBoardingPage(VisibleOnboardingPage.dailyCartoon),
      ]);
    });

    testWidgets(
      'setOnboarding page called twice '
      'when next button is tapped', (tester) async {
      when(() => onboardingPageCubit.state)
        .thenReturn(VisibleOnboardingPage.welcome);

      await tester.pumpApp(wrapper(const OnboardingView()));
      await tester.tap(find.byKey(nextPageOnboardingButtonKey));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(nextPageOnboardingButtonKey));
      await tester.pumpAndSettle();

      verifyInOrder([
        () => onboardingPageCubit
          .setOnBoardingPage(VisibleOnboardingPage.dailyCartoon),
        () => onboardingPageCubit
          .setOnBoardingPage(VisibleOnboardingPage.allCartoons),
      ]);
    });

    testWidgets(
      'completes onboarding '
      'when start button is tapped', (tester) async {
      when(() => onboardingPageCubit.state)
        .thenReturn(VisibleOnboardingPage.allCartoons);
      
      await tester.pumpApp(wrapper(const OnboardingView()));
      expect(find.text('Start'), findsOneWidget);
      await tester.tap(find.byKey(startCompleteOnboardingButtonKey));
      await tester.pumpAndSettle();
      
      verify(onboardingSeenCubit.setSeenOnboarding).called(1);
    });

    testWidgets(
      'completes onboarding '
      'when skip button is tapped', (tester) async {
      when(() => onboardingPageCubit.state)
        .thenReturn(VisibleOnboardingPage.dailyCartoon);

      await tester.pumpApp(wrapper(const OnboardingView()));
      await tester.tap(find.byKey(setSeenOnboardingButtonKey));
      await tester.pumpAndSettle();

      verify(onboardingSeenCubit.setSeenOnboarding).called(1);
    });
  });
}
