import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:hawktoons/widgets/widgets.dart';

class OnboardingPage extends Page<void> {
  const OnboardingPage() : super(key: const ValueKey('OnBoardingPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (_, __, ___) => const OnboardingView(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final int totalPages = VisibleOnboardingPage.values.length;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInCubic
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final currentPage = context.select<OnboardingCubit, VisibleOnboardingPage>(
      (cubit) => cubit.state.onboardingPage
    );

    final isLastPage = totalPages - 1 == currentPage.index;

    List<Widget> _buildPageIndicator() {
      final list = <Widget>[];
      for (var i = 0; i < totalPages; i++) {
        list.add(
          PageIndicator(isActive: i == currentPage.index ? true : false)
        );
      }
      return list;
    }

    void _completeOnboarding() {
      context.read<OnboardingCubit>().setSeenOnboarding();
    }

    void _onPageChanged(int page) {
      context.read<OnboardingCubit>().setOnboardingPage(
        VisibleOnboardingPage.values[page]
      );
    }

    final _baseTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.60,
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: [
                    OnboardingWidget(
                      header: l10n.onboardingPageHeader1,
                      body: l10n.onboardingPageBody1,
                    ),
                    OnboardingWidget(
                      header: l10n.onboardingPageHeader2,
                      body: l10n.onboardingPageBody2,
                    ),
                    OnboardingWidget(
                      header: l10n.onboardingPageHeader3,
                      body: l10n.onboardingPageBody3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: isLastPage ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    child: IgnorePointer(
                      ignoring: isLastPage,
                      child: OnboardingTextButton(
                        excludeSemantics: isLastPage,
                        key: const Key('OnboardingPage_SetSeenOnboarding'),
                        text: l10n.onboardingPageSkipButtonText,
                        label: l10n.onboardingPageSkipButtonLabel,
                        hint: l10n.onboardingPageSkipButtonHint,
                        onPressed: _completeOnboarding,
                        textStyle: _baseTextStyle,
                      ),
                    )
                  ),
                  const SizedBox(width: 40),
                  ..._buildPageIndicator(),
                  const SizedBox(width: 40),
                  AnimatedCrossFade(
                    firstCurve: Curves.ease,
                    firstChild: OnboardingTextButton(
                      key: const Key('OnboardingPage_NextPage'),
                      text: l10n.onboardingPageNextButtonText,
                      label: l10n.onboardingPageNextButtonLabel,
                      hint: l10n.onboardingPageNextButtonHint,
                      onPressed: _nextPage,
                      textStyle: _baseTextStyle.copyWith(
                        color: colorScheme.primary
                      ),
                    ),
                    secondCurve: Curves.ease,
                    secondChild: OnboardingTextButton(
                      key: const Key('OnboardingPage_StartButton'),
                      text: l10n.onboardingPageStartButtonText,
                      label: l10n.onboardingPageStartButtonLabel,
                      hint: l10n.onboardingPageStartButtonHint,
                      onPressed: _completeOnboarding,
                      textStyle: _baseTextStyle.copyWith(
                        color: colorScheme.primary
                      ),
                    ),
                    crossFadeState: isLastPage
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 100),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
