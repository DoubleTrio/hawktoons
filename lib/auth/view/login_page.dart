import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:history_app/widgets/loading_indicator.dart';
import 'package:history_app/widgets/scaffold_title.dart';

class LoginPage extends Page {
  LoginPage() : super(key: const ValueKey('LoginPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
      transitionDuration: const Duration(milliseconds: 1000),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: ScaffoldTitle(title: 'Login'), centerTitle: true),
        body: Column(
          children: [
            const Text(
              'Hawktoons App',
              style: TextStyle(fontSize: 30),
            ),
            Center(
              child: TextButton(
                key: const Key('LoginPage_SignInAnonymouslyButton'),
                child: const Text('Sign in anonymously'),
                onPressed: () =>
                    context.read<AuthenticationBloc>().add(SignInAnonymously()),
              ),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is Authenticated || state is Uninitialized) {
                  return const SizedBox.shrink();
                }

                if (state is LoggingIn) {
                  return LoadingIndicator(
                      key: const Key('LoginPage_LoggingIn'));
                }

                return const Text(
                  'Unauthenticated',
                  key: Key('LoginPage_Unauthenticated'),
                );
              },
            ),
          ],
        ));
  }
}
