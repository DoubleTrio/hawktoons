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
      pageBuilder: (_, __, ___) => const LoginScreen(),
      transitionDuration: const Duration(milliseconds: 1000),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _signInAnonymously = () =>
      context.read<AuthenticationBloc>().add(SignInAnonymously());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Hawktoons App',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Center(
              child: TextButton(
                key: const Key('LoginPage_SignInAnonymouslyButton'),
                onPressed: _signInAnonymously,
                child: const Text('Sign in anonymously'),
              ),
            ),
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
                return const Text(
                  'Login Error',
                  key: Key('LoginPage_LoginError'),
                );
              },
            ),
          ],
        ),
      )
    );
  }
}
