import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';
import 'package:hawktoons/widgets/app_scroll_bar.dart';
import 'package:hawktoons/widgets/cartoon_body/cartoon_body.dart';
import 'package:hawktoons/widgets/custom_icon_button.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class DetailsPage extends Page<void> {
  DetailsPage({required this.cartoon})
    : super(key: const ValueKey('DetailsPage'));

  final PoliticalCartoon cartoon;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) =>
        DetailsView(cartoon: cartoon),
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = const Offset(1.0, 0.0);
        final end = Offset.zero;
        final curve = Curves.easeInCubic;

        final tween = Tween(begin: begin, end: end)
          ..chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key, required this.cartoon}) : super(key: key);

  final PoliticalCartoon cartoon;

  @override
  Widget build(BuildContext context) {
    void _deselectCartoon() {
      context.read<SelectCartoonCubit>().deselectCartoon();
    }

    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          label: 'Back button',
          hint: 'Tap to navigate back to all the political images',
          key: const Key('DetailsPage_BackButton'),
          icon: const Icon(Icons.arrow_back),
          onPressed: _deselectCartoon,
        )
      ),
      body: AppScrollBar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: CartoonBody(cartoon: cartoon)
        ),
      ),
    );
  }
}
