import 'package:firebase_auth/firebase_auth.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:hawktoons/home/home.dart';
import 'package:mockito/mockito.dart';

class FakeUser extends Fake implements User {}

class FakeSelectPoliticalCartoonState extends Fake
  implements SelectPoliticalCartoonState {}

class FakeAuthenticationState extends Fake implements AuthenticationState {}

class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}

class FakeDailyCartoonState extends Fake implements DailyCartoonState {}

class FakeDailyCartoonEvent extends Fake implements DailyCartoonEvent {}

class FakeAllCartoonsState extends Fake implements AllCartoonsState {}

class FakeAllCartoonsEvent extends Fake implements AllCartoonsEvent {}

class FakeTabEvent extends Fake implements TabEvent {}
