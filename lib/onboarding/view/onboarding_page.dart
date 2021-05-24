import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/onboarding/onboarding.dart';

class OnBoardingPage extends Page<void> {
  const OnBoardingPage() : super(key: const ValueKey('OnBoardingPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (_, __, ___) => BlocProvider(
        create: (context) => OnboardingPageCubit(),
        child: const OnboardingView(),
      ),
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
    final colorScheme = Theme.of(context).colorScheme;
    final currentPage = context.watch<OnboardingPageCubit>().state;
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
      context.read<OnboardingSeenCubit>().setSeenOnboarding();
    }

    void _onPageChanged(int page) {
      context.read<OnboardingPageCubit>().setOnBoardingPage(
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
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.60,
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: [
                    const OnboardingWidget(
                      header: 'Welcome to Hawktoons',
                      body: 'An educational, ad-free app to learn history '
                        'at different time periods through '
                        'political cartoons and images.'
                    ),
                    const OnboardingWidget(
                      header: 'New cartoon every week',
                      body: 'Learn something new with a political cartoon '
                        'or image every week. Each will include a '
                        'brief description given the context of the time '
                        'period.'
                    ),
                    const OnboardingWidget(
                      header: 'See past cartoons',
                      body: 'Missed a political cartoon? Don\'t worry! '
                        'You can view past political images '
                        'and filter them by their tags and image type.'
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
                        label: 'Skip introduction button',
                        hint: 'Tap to skip the introduction',
                        key: const Key('OnboardingPage_SetSeenOnboarding'),
                        text: 'Skip',
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
                      label: 'Next page button',
                      hint: 'Tap to move to the last page',
                      key: const Key('OnboardingPage_NextPage'),
                      text: 'Next',
                      onPressed: _nextPage,
                      textStyle: _baseTextStyle.copyWith(
                        color: colorScheme.primary
                      ),
                    ),
                    secondCurve: Curves.ease,
                    secondChild: OnboardingTextButton(
                      label: 'Start button',
                      hint: 'Tap to move to the next page',
                      key: const Key('OnboardingPage_StartButton'),
                      text: 'Start',
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
