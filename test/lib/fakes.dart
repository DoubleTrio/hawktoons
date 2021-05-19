import 'package:history_app/all_cartoons/blocs/blocs.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/home/home.dart';
import 'package:mockito/mockito.dart';

class FakeSelectPoliticalCartoonState extends Fake
  implements SelectPoliticalCartoonState {}

class FakeAuthenticationState extends Fake implements AuthenticationState {}

class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}

class FakeDailyCartoonState extends Fake implements DailyCartoonState {}

class FakeDailyCartoonEvent extends Fake implements DailyCartoonEvent {}

class FakeAllCartoonsState extends Fake implements AllCartoonsState {}

class FakeAllCartoonsEvent extends Fake implements AllCartoonsEvent {}

class FakeTabEvent extends Fake implements TabEvent {}
