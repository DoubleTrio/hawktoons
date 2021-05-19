import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent();
}

class SignInAnonymously extends AuthenticationEvent {
  @override
  String toString() => 'SignInAnonymously';

  @override
  List<Object> get props => [];
}

class Logout extends AuthenticationEvent {
  @override
  String toString() => 'Logout';

  @override
  List<Object> get props => [];
}