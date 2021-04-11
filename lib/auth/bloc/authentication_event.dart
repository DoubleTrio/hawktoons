import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent();
}

class StartApp extends AuthenticationEvent {
  @override
  String toString() => 'StartApp';

  @override
  List<Object> get props => [];
}
