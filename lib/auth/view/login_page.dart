import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:history_app/home/home_flow.dart';

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
          body: Column(
            children: [
              Center(
                child: TextButton(
                  key: const Key('LoginPage_SignInAnonymouslyButton'),
                  child: const Text('Sign in anonymously'),
                  onPressed: () => context
                      .read<AuthenticationBloc>()
                      .add(SignInAnonymously()),
                ),
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  print(state);
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator(
                        key: Key('LoginPage_AuthLoading'));
                  }

                  if (state is Authenticated || state is Uninitialized) {
                    return const SizedBox.shrink();
                  }

                  return const Text(
                    'Unauthenticated',
                    key: Key('LoginPage_Unauthenticated'),
                  );
                },
              ),
            ],
          )),
    );
  }
}
