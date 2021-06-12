import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
// import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/widgets/widgets.dart';

class CreateCartoonPopUp extends StatefulWidget {
  const CreateCartoonPopUp({Key? key}) : super(key: key);

  @override
  State<CreateCartoonPopUp> createState() => _CreateCartoonPopUpState();
}

class _CreateCartoonPopUpState extends State<CreateCartoonPopUp> {
  final int totalPages = CreateCartoonPage.values.length;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  // void _nextPage() {
  //   _pageController.nextPage(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInCubic
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    // final colorScheme = Theme.of(context).colorScheme;
    // final currentPage = context.watch<CreateCartoonPageCubit>().state;
    // final isLastPage = totalPages - 1 == currentPage.index;

    // List<Widget> _buildPageIndicator() {
    //   final list = <Widget>[];
    //   for (var i = 0; i < totalPages; i++) {
    //     list.add(
    //         PageIndicator(isActive: i == currentPage.index ? true : false)
    //     );
    //   }
    //   return list;
    // }

    void _onPageChanged(int page) {
      context.read<CreateCartoonPageCubit>().setPage(
        CreateCartoonPage.values[page]
      );
    }

    return CustomDraggableSheet(
      child: Center(
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
                ],
              ),
            ),
            const SizedBox(height: 60),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     AnimatedOpacity(
            //         opacity: isLastPage ? 0 : 1,
            //         duration: const Duration(milliseconds: 300),
            //         child: IgnorePointer(
            //           ignoring: isLastPage,
            //           child: OnboardingTextButton(
            //             excludeSemantics: isLastPage,
            //             key: const Key('OnboardingPage_SetSeenOnboarding'),
            //             text: l10n.onboardingPageSkipButtonText,
            //             label: l10n.onboardingPageSkipButtonLabel,
            //             hint: l10n.onboardingPageSkipButtonHint,
            //             onPressed: _completeOnboarding,
            //             textStyle: _baseTextStyle,
            //           ),
            //         )
            //     ),
            //     const SizedBox(width: 40),
            //     ..._buildPageIndicator(),
            //     const SizedBox(width: 40),
            //     AnimatedCrossFade(
            //       firstCurve: Curves.ease,
            //       firstChild: OnboardingTextButton(
            //         key: const Key('OnboardingPage_NextPage'),
            //         text: l10n.onboardingPageNextButtonText,
            //         label: l10n.onboardingPageNextButtonLabel,
            //         hint: l10n.onboardingPageNextButtonHint,
            //         onPressed: _nextPage,
            //         textStyle: _baseTextStyle.copyWith(
            //             color: colorScheme.primary
            //         ),
            //       ),
            //       secondCurve: Curves.ease,
            //       secondChild: OnboardingTextButton(
            //         key: const Key('OnboardingPage_StartButton'),
            //         text: l10n.onboardingPageStartButtonText,
            //         label: l10n.onboardingPageStartButtonLabel,
            //         hint: l10n.onboardingPageStartButtonHint,
            //         onPressed: _completeOnboarding,
            //         textStyle: _baseTextStyle.copyWith(
            //             color: colorScheme.primary
            //         ),
            //       ),
            //       crossFadeState: isLastPage
            //           ? CrossFadeState.showSecond
            //           : CrossFadeState.showFirst,
            //       duration: const Duration(milliseconds: 100),
            //     )
              ],
            ),
           )
    );
  }
}
