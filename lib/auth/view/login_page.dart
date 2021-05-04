import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:history_app/home/home_flow.dart';

class LoginPage extends Page {
  LoginPage() : super(key: const ValueKey('LoginPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated)
          Navigator.of(context).pushReplacement(HomeFlow.route());
      },
      child: Scaffold(
          appBar: AppBar(
              title:
                  Text(context.watch<AuthenticationBloc>().state.toString())),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: TextButton(
                child: const Text('Sign in anonymously'),
                onPressed: () =>
                    context.read<AuthenticationBloc>().add(SignInAnonymously()),
              ),
            ),
          )),
    );
  }
}
