import 'package:history_app/blocs/blocs.dart';
import 'package:history_app/daily_cartoon/bloc/daily_cartoon.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:mockito/mockito.dart';

class FakeAuthenticationState extends Fake implements AuthenticationState {}
class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}

class FakeDailyCartoonState extends Fake implements DailyCartoonState {}
class FakeDailyCartoonEvent extends Fake implements DailyCartoonEvent {}

class FakeAllCartoonsState extends Fake implements AllCartoonsState {}
class FakeAllCartoonsEvent extends Fake implements AllCartoonsEvent {}

class FakeFilteredCartoonsState extends Fake implements FilteredCartoonsState {}
class FakeFilteredCartoonsEvent extends Fake implements FilteredCartoonsEvent {}

class FakeTabEvent extends Fake implements TabEvent {}