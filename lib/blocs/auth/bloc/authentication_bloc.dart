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
    }
  }

  Stream<AuthenticationState> _mapSignInAnonymouslyToState() async* {
    try {
      yield AuthLoading();
      final isSignedIn = await userRepository.isAuthenticated();
      if (!isSignedIn) {
        await userRepository.authenticate();
      }
      final userId = await userRepository.getUserId();
      yield Authenticated(userId);
    } on Exception {
      yield Unauthenticated();
    }
  }
}
