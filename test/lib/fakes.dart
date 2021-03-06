import 'package:firebase_auth/firebase_auth.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:hawktoons/latest_cartoon/bloc/latest_cartoon.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:mockito/mockito.dart';

class FakeAllCartoonsState extends Fake implements AllCartoonsState {}
class FakeAllCartoonsEvent extends Fake implements AllCartoonsEvent {}
class FakeAllCartoonsPageState extends Fake implements AllCartoonsPageState {}
class FakeAppearancesState extends Fake implements AppearancesState {}
class FakeAuthenticationState extends Fake implements AuthenticationState {}
class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}
class FakeCartoonFilters extends Fake implements CartoonFilters {}
class FakeCreateCartoonSheetState extends Fake
  implements CreateCartoonSheetState {}
class FakeCreateCartoonSheetEvent extends Fake
  implements CreateCartoonSheetEvent {}
class FakeLatestCartoonState extends Fake implements LatestCartoonState {}
class FakeLatestCartoonEvent extends Fake implements LatestCartoonEvent {}
class FakeSelectPoliticalCartoonState extends Fake
    implements SelectPoliticalCartoonState {}
class FakeOnboardingState extends Fake implements OnboardingState {}
class FakeTabEvent extends Fake implements TabEvent {}

class FakeUser extends Fake implements User {
  @override
  bool get isAnonymous => false;

  @override
  String? get email => '123example@gmail.com';

  @override
  String? get displayName => 'Display Name';

  @override
  String? get photoURL => 'fake_url';

  @override
  String get uid => 'user_id';
}