import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.userRepository}) : super(Uninitialized());

  final UserRepository userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is SignInAnonymously) {
      yield* _mapSignInAnonymouslyToState();
    } else if (event is Logout) {
      yield* _mapLogoutToState();
    }
  }

  Stream<AuthenticationState> _mapSignInAnonymouslyToState() async* {
    try {
      yield LoggingIn();
      final isSignedIn = await userRepository.isAuthenticated();
      if (!isSignedIn) {
        await userRepository.authenticate();
      }
      final userId = await userRepository.getUserId();
      yield Authenticated(userId);
    } on Exception {
      yield LoginError();
    }
  }

  Stream<AuthenticationState> _mapLogoutToState() async* {
    try {
      yield LoggingOut();
      await userRepository.logout();
      yield Uninitialized();
    } on Exception {
      yield LogoutError();
    }
  }
}
