import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/auth/bloc/auth.dart';
import 'package:history_app/widgets/loading_indicator.dart';

class LoginPage extends Page<void> {
  const LoginPage() : super(key: const ValueKey('LoginPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (_, __, ___) => const LoginView(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _signInAnonymously = () =>
      context.read<AuthenticationBloc>().add(const SignInAnonymously());

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    const Text(
                      'Welcome to Hawktoons!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      'To begin learning about history through '
                      'political cartoons and images, '
                      'sign in anonymously below!',
                      style: TextStyle(
                        fontSize: 17,
                        color: colorScheme.onBackground,
                        letterSpacing: 1.1
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    key: const Key('LoginPage_SignInAnonymouslyButton'),
                    onPressed: _signInAnonymously,
                    child: Semantics(
                      button: true,
                      label: 'Sign in anonymously button',
                      hint: 'Click to sign in anonymously',
                      child: Text(
                        'Sign in anonymously',
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onPrimary,
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is Authenticated || state is Uninitialized) {
                        return const SizedBox.shrink();
                      }
                      if (state is LoggingIn) {
                        return const LoadingIndicator(
                          key: Key('LoginPage_LoggingIn')
                        );
                      }
                      return Text(
                        'A login error has occurred',
                        key: const Key('LoginPage_LoginError'),
                        style: TextStyle(
                          color: colorScheme.error,
                          fontSize: 14
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
