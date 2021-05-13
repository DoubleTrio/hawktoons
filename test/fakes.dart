import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:mockito/mockito.dart';

class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}
class FakeAuthenticationState extends Fake implements AuthenticationState {}

class FakeDailyCartoonEvent extends Fake implements DailyCartoonEvent {}
class FakeDailyCartoonState extends Fake implements DailyCartoonState {}