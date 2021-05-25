import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
  extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc({required this.userRepository})
    : super(const Uninitialized());

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
      yield const LoggingIn();
      final isSignedIn = await userRepository.isAuthenticated();
      if (!isSignedIn) {
        await userRepository.authenticate();
      }
      final user = await userRepository.getUser();
      yield Authenticated(user);
    } on Exception {
      yield const LoginError();
    }
  }

  Stream<AuthenticationState> _mapSignWithGoogleToState() async* {
    try {
      yield const LoggingIn();
      final isSignedIn = await userRepository.isAuthenticated();
      if (!isSignedIn) {
        await userRepository.signInWithGoogle();
      }
      final user = await userRepository.getUser();
      if (user != null) {
        yield Authenticated(user);
      } else {
        yield const Uninitialized();
      }
    } on Exception {
      yield const LoginError();
    }
  }

  Stream<AuthenticationState> _mapLogoutToState() async* {
    try {
      yield const LoggingOut();
      await userRepository.logout();
      yield const Uninitialized();
    } on Exception {
      yield const LogoutError();
    }
  }
}
