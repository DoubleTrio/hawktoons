import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Uninitialized extends AuthenticationState {
  const Uninitialized();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Uninitialized';
}

class LoggingIn extends AuthenticationState {
  const LoggingIn();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoggingIn';
}

class LoggingOut extends AuthenticationState {
  const LoggingOut();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoggingOut';
}

class Authenticated extends AuthenticationState {
  const Authenticated(this.user);

  final User? user;

  bool? get isAnonymous => user?.isAnonymous;

  @override
  List<Object?> get props => [user];

  @override
  String toString() => 'Authenticated($user)';
}

class LoginError extends AuthenticationState {
  const LoginError();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginError';
}

class LogoutError extends AuthenticationState {
  const LogoutError();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LogoutError';
}
