import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class SignInAnonymously extends AuthenticationEvent {
  const SignInAnonymously();

  @override
  List<Object> get props => [];
}

class Logout extends AuthenticationEvent {
  const Logout();

  @override
  List<Object> get props => [];
}