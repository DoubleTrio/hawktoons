import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_app/blocs/auth/auth.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushNamed('/daily');
          } else if (state is Unauthenticated) {
            Navigator.of(context).pushNamed('/error');
          }
        },
        builder: (context, state) {
          if (state is Uninitialized) {
            return const CircularProgressIndicator();
          } else {
            return const Text('Error');
          }
        },
      ),
    );
  }
}
