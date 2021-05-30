import 'package:firebase_auth/firebase_auth.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/latest_cartoon/bloc/latest_cartoon.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:mockito/mockito.dart';

class FakeAllCartoonsState extends Fake implements AllCartoonsState {}
class FakeAllCartoonsEvent extends Fake implements AllCartoonsEvent {}
class FakeAuthenticationState extends Fake implements AuthenticationState {}
class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}
class FakeLatestCartoonState extends Fake implements LatestCartoonState {}
class FakeLatestCartoonEvent extends Fake implements LatestCartoonEvent {}
class FakeSelectPoliticalCartoonState extends Fake
    implements SelectPoliticalCartoonState {}
class FakeTabEvent extends Fake implements TabEvent {}
class FakeUser extends Fake implements User {
  @override
  bool get isAnonymous => false;
}