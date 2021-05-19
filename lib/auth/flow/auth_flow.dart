import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/home/flow/home_flow.dart';

class AuthFlowPage extends Page<void> {
  const AuthFlowPage() : super(key: const ValueKey('AuthFlowPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => const AuthFlow(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = const Offset(1.0, 0.0);
        final end = Offset.zero;
        final curve = Curves.ease;
        final tween = Tween(begin: begin, end: end)
          ..chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
    );
  }
}

class AuthFlow extends StatelessWidget {
  const AuthFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AuthenticationState>(
      state: context.watch<AuthenticationBloc>().state,
      onGeneratePages: (state, pages) {
        return [
          const LoginPage(),
          if (state is Authenticated) const HomeFlowPage()
        ];
      }
    );
  }
}
