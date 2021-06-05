import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
  extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc({required this.userRepository})
    : super(const AuthenticationState.uninitialized());

  final UserRepository userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is SignInAnonymously) {
      yield* _mapSignInAnonymouslyToState();
    } else if (event is SignInWithGoogle) {
      yield* _mapSignWithGoogleToState();
    } else if (event is Logout) {
      yield* _mapLogoutToState();
    }
  }

  Stream<AuthenticationState> _mapSignInAnonymouslyToState() async* {
    try {
      yield const AuthenticationState.loggingIn();
      final isSignedIn = await userRepository.isAuthenticated();
      if (!isSignedIn) {
        await userRepository.authenticate();
      }
      final user = await userRepository.getUser();
      yield AuthenticationState.authenticated(user);
    } on Exception {
      yield const AuthenticationState.loginError();
    }
  }

  Stream<AuthenticationState> _mapSignWithGoogleToState() async* {
    try {
      yield const AuthenticationState.loggingIn();
      final isSignedIn = await userRepository.isAuthenticated();
      if (!isSignedIn) {
        await userRepository.signInWithGoogle();
      }
      final user = await userRepository.getUser();
      if (user != null) {
        yield AuthenticationState.authenticated(user);
      } else {
        yield const AuthenticationState.uninitialized();
      }
    } on Exception {
      yield const AuthenticationState.loginError();
    }
  }

  Stream<AuthenticationState> _mapLogoutToState() async* {
    try {
      yield AuthenticationState.loggingOut(state.user);
      await userRepository.logout();
      yield AuthenticationState.logoutUninitialized(state.user);
    } on Exception {
      yield const AuthenticationState.logoutError();
    }
  }
}
