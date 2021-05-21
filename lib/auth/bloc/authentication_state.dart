import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Uninitialized extends AuthenticationState {
  const Uninitialized();

  @override
  List<Object> get props => [];
}

class LoggingIn extends AuthenticationState {
  const LoggingIn();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  const Authenticated(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];
}

class LoginError extends AuthenticationState {
  const LoginError();

  @override
  List<Object> get props => [];
}

class LogoutError extends AuthenticationState {
  const LogoutError();

  @override
  List<Object> get props => [];
}

class LoggingOut extends AuthenticationState {
  const LoggingOut();

  @override
  List<Object> get props => [];
}
