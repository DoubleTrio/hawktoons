import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:hawktoons/latest_cartoon/latest_cartoon.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

final mockPoliticalCartoon = PoliticalCartoon(
  id: '2',
  author: 'Bob',
  timestamp: Timestamp.now(),
  published: Timestamp.now(),
  description: 'Another Mock Political Cartoon',
  tags: [Tag.tag1],
  downloadUrl: 'downloadurl',
  type: ImageType.cartoon
);

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

class MockCartoonRepository extends Mock
  implements FirestorePoliticalCartoonRepository {}

class MockFirebaseUserRepository extends Mock
  implements FirebaseUserRepository {}

class MockAppDrawerCubit extends MockCubit<bool>
  implements AppDrawerCubit {}

class MockAppearancesCubit extends MockCubit<AppearancesState>
  implements AppearancesCubit {}

class MockAllCartoonsPageCubit extends MockCubit<AllCartoonsPageState>
  implements AllCartoonsPageCubit {}

class MockAllCartoonsBloc extends MockBloc<AllCartoonsEvent, AllCartoonsState>
  implements AllCartoonsBloc {}

class MockAuthenticationBloc
  extends MockBloc<AuthenticationEvent, AuthenticationState>
  implements AuthenticationBloc {}

class MockCreateCartoonSheetBloc extends
  MockBloc<CreateCartoonSheetEvent, CreateCartoonSheetState>
  implements CreateCartoonSheetBloc {}

class MockLatestCartoonBloc
  extends MockBloc<LatestCartoonEvent, LatestCartoonState>
  implements LatestCartoonBloc {}

class MockFiltersCubit extends MockCubit<CartoonFilters>
  implements FilterSheetCubit {}

class MockOnboardingCubit extends MockCubit<OnboardingState>
  implements OnboardingCubit {}

class MockSettingsScreenCubit extends MockCubit<SettingsScreen>
  implements SettingsScreenCubit {}


class MockTabBloc extends MockBloc<TabEvent, AppTab> implements TabBloc {}
