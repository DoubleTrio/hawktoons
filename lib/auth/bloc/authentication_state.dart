import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthenticationStatus {
  uninitialized,
  authenticated,
  loggingIn,
  loggingOut,
  loginError,
  logoutError,
}

class AuthenticationState extends Equatable {
  const AuthenticationState({ this.user, required this.status });

  const AuthenticationState.uninitialized()
    : this(status: AuthenticationStatus.uninitialized);

  const AuthenticationState.loggingIn()
    : this(status: AuthenticationStatus.loggingIn);

  const AuthenticationState.loggingOut(User? user)
    : this(user: user, status: AuthenticationStatus.loggingOut);

  const AuthenticationState.loginError()
    : this(status: AuthenticationStatus.loginError);

  const AuthenticationState.logoutError()
    : this(status: AuthenticationStatus.logoutError);

  const AuthenticationState.authenticated(User? user)
    : this(user: user, status: AuthenticationStatus.authenticated);

  const AuthenticationState.logoutUninitialized(User? user)
    : this(user: user, status: AuthenticationStatus.uninitialized);


  final User? user;
  final AuthenticationStatus status;

  @override
  List<Object?> get props => [user, status];
}