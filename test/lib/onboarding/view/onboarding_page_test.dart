import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:history_app/onboarding/onboarding.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';


class MockOnboardingPageCubit extends MockCubit<VisableOnboardingPage>
  implements OnboardingPageCubit {}

class MockOnboardingSeenCubit extends MockCubit<bool>
  implements OnboardingSeenCubit {}

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
      registerFallbackValue<VisableOnboardingPage>(
        VisableOnboardingPage.welcome
      );
      onboardingPageCubit = MockOnboardingPageCubit();
      onboardingSeenCubit = MockOnboardingSeenCubit();
      when(() => onboardingSeenCubit.state).thenReturn(false);
    });

    testWidgets(
      'setOnboarding page called twice when swiped', (tester) async {

      when(() => onboardingPageCubit.state)
        .thenReturn(VisableOnboardingPage.welcome
      );

      await tester.pumpApp(wrapper(const OnboardingScreen()));
      await tester.drag(find.byType(OnboardingWidget), const Offset(-1000, 0));
      await tester.drag(find.byType(OnboardingWidget), const Offset(-1000, 0));
      await tester.drag(find.byType(OnboardingWidget), const Offset(1000, 0));

      verifyInOrder([
        () => onboardingPageCubit
          .setOnBoardingPage(VisableOnboardingPage.dailyCartoon),
        () => onboardingPageCubit
          .setOnBoardingPage(VisableOnboardingPage.allCartoons),
        () => onboardingPageCubit
          .setOnBoardingPage(VisableOnboardingPage.dailyCartoon),
      ]);
    });

    testWidgets('setOnboarding page called twice '
      'when next button is tapped', (tester) async {

      when(() => onboardingPageCubit.state)
        .thenReturn(VisableOnboardingPage.welcome);

      await tester.pumpApp(wrapper(const OnboardingScreen()));
      await tester.tap(find.byKey(nextPageOnboardingButtonKey));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(nextPageOnboardingButtonKey));
      await tester.pumpAndSettle();

      verifyInOrder([
        () => onboardingPageCubit
          .setOnBoardingPage(VisableOnboardingPage.dailyCartoon),
        () => onboardingPageCubit
          .setOnBoardingPage(VisableOnboardingPage.allCartoons),
      ]);
    });

    testWidgets('completes onboarding '
      'when start button is tapped', (tester) async {

      when(() => onboardingPageCubit.state)
        .thenReturn(VisableOnboardingPage.allCartoons);

      await tester.pumpApp(wrapper(const OnboardingScreen()));
      await tester.tap(find.byKey(nextPageOnboardingButtonKey));
      await tester.pumpAndSettle();

      expect(find.text('Start'), findsOneWidget);
      verify(onboardingSeenCubit.setSeenOnboarding).called(1);
    });

    testWidgets('completes onboarding '
      'when skip button is tapped', (tester) async {

      when(() => onboardingPageCubit.state)
        .thenReturn(VisableOnboardingPage.dailyCartoon);

      await tester.pumpApp(wrapper(const OnboardingScreen()));
      await tester.tap(find.byKey(setSeenOnboardingButtonKey));
      await tester.pumpAndSettle();

      verify(onboardingSeenCubit.setSeenOnboarding).called(1);
    });
  });
}