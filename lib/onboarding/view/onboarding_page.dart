import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/onboarding/cubits/cubits.dart';
import 'package:history_app/onboarding/cubits/onboarding_page_cubit.dart';
import 'package:history_app/onboarding/models/models.dart';

class OnBoardingPage extends Page {
  OnBoardingPage() : super(key: const ValueKey('OnBoardingPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (context) => OnboardingPageCubit(),
        child: OnboardingScreen(),
      ),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int totalPages = VisableOnboardingPage.values.length;
  final PageController _pageController =
      PageController(initialPage: VisableOnboardingPage.welcome.index);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var currentPage = context.watch<OnboardingPageCubit>().state;

    List<Widget> _buildPageIndicator() {
      var list = <Widget>[];
      for (var i = 0; i < totalPages; i++) {
        list.add(OnboardingPageIndicator(
            isActive: i == currentPage.index ? true : false));
      }
      return list;
    }

    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      context.read<OnboardingCubit>().setSeenOnboarding(),
                  child: const Text(
                    'Skip',
                  ),
                ),
              ),
              Container(
                height: 600.0,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    context
                        .read<OnboardingPageCubit>()
                        .setOnBoardingPage(VisableOnboardingPage.values[page]);
                  },
                  children: [
                    OnboardingWidget(
                        header: 'Welcome to Hawktoons',
                        body:
                            'An education ad-free app to learn about history through political cartoons'),
                    OnboardingWidget(
                        header: 'A new political cartoon everyday',
                        body:
                            'Learn something new everyday in history everyday'),
                    OnboardingWidget(
                        header: 'A collection of political cartoons',
                        body: 'Missed a political cartoon? Don\'t worry! '
                            'You can view past political cartoons and filter them by their tags'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              AnimatedOpacity(
                  opacity: totalPages - 1 == currentPage.index ? 0 : 1,
                  duration: const Duration(milliseconds: 800),
                  child: IgnorePointer(
                    ignoring:
                        totalPages - 1 == currentPage.index ? true : false,
                    child: MaterialButton(
                      onPressed: () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInCubic),
                      color: colorScheme.primary,
                      textColor: colorScheme.onPrimary,
                      child: const Icon(
                        Icons.chevron_right_outlined,
                        size: 30,
                      ),
                      padding: const EdgeInsets.all(12),
                      shape: const CircleBorder(),
                    ),
                  ))
            ],
          ),
        ),
      ),

      // bottomSheet: _currentPage == _numPages - 1
      //     ? Container(
      //         height: 100.0,
      //         width: double.infinity,
      //         color: Colors.white,
      //         child: GestureDetector(
      //           onTap: () => print('Get started'),
      //           child: Center(
      //             child: Padding(
      //               padding: EdgeInsets.only(bottom: 30.0),
      //               child: Text(
      //                 'Get started',
      //                 style: TextStyle(
      //                   color: Color(0xFF5B16D0),
      //                   fontSize: 20.0,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       )
      //     : Text(''),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingWidget extends StatelessWidget {
  OnboardingWidget({
    required this.header,
    required this.body,
    this.child,
    this.assetImage,
  });

  final String header;
  final String body;
  final String? assetImage;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 30.0),
          Text(
            header,
            // style: kTitleStyle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 15.0),
          Text(
            body,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class OnboardingPageIndicator extends StatelessWidget {
  OnboardingPageIndicator({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.onBackground,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
