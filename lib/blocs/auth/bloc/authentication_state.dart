import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState();
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';

  @override
  List<Object> get props => [];
}

class LoggingIn extends AuthenticationState {
  @override
  String toString() => 'LoggingIn';

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  Authenticated(this.userId);
  final String userId;

  @override
  String toString() => 'Authenticated { userId: $userId }';

  @override
  List<Object> get props => [userId];
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object> get props => [];
}

class LogoutError extends AuthenticationState {
  @override
  String toString() => 'LogoutError';

  @override
  List<Object> get props => [];
}

class LoggingOut extends AuthenticationState {
  @override
  String toString() => 'LoggingOut';

  @override
  List<Object> get props => [];
}
