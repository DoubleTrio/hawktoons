import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawktoons/auth/bloc/auth.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/widgets/widgets.dart';

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
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    void _signInAnonymously(){
      context.read<AuthenticationBloc>().add(const SignInAnonymously());
    }

    void _signInWithGoogle() {
      context.read<AuthenticationBloc>().add(const SignInWithGoogle());
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 40.0
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Text(
                        l10n.loginPageHeader,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        l10n.loginPageSubheader,
                        style: TextStyle(
                          fontSize: 18,
                          color: colorScheme.onBackground,
                          letterSpacing: 1.05
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedIconButton(
                      key: const Key('LoginPage_SignInAnonymouslyButton'),
                      onTap: _signInAnonymously,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      label: l10n.loginPageSignInAnonymouslyButtonLabel,
                      hint: l10n.loginPageSignInAnonymouslyButtonHint,
                      icon: const Icon(Icons.people, size: 24),
                      text:  Text(
                        l10n.loginPageSignInAnonymouslyButtonText,
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedIconButton(
                      key: const Key('LoginPage_SignInWithGoogleButton'),
                      onTap: _signInWithGoogle,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      label: l10n.loginPageGoogleSignInButtonLabel,
                      hint: l10n.loginPageSignInAnonymouslyButtonHint,
                      icon: Image.asset('assets/images/app/g-logo.png', height: 28),
                      text:  Text(
                        l10n.loginPageGoogleSignInButtonText,
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
                          l10n.loginPageErrorText,
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
        ),
      )
    );
  }
}
