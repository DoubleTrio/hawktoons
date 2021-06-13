import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/create_cartoon_sheet/blocs/blocs.dart';
import 'package:hawktoons/latest_cartoon/latest_cartoon.dart';
import 'package:hawktoons/onboarding/onboarding.dart';
import 'package:hawktoons/settings/settings.dart';
import 'package:hawktoons/tab/tab.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

final mockFilter = const CartoonFilters.initial();

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

class MockAllCartoonsPageCubit extends MockCubit<AllCartoonsPageState>
  implements AllCartoonsPageCubit {}

class MockAllCartoonsBloc extends MockBloc<AllCartoonsEvent, AllCartoonsState>
  implements AllCartoonsBloc {}

class MockAuthenticationBloc
  extends MockBloc<AuthenticationEvent, AuthenticationState>
  implements AuthenticationBloc {}

class MockCartoonViewCubit extends MockCubit<CartoonView>
  implements CartoonViewCubit {}

class MockCreateCartoonPageCubit extends MockCubit<CreateCartoonPage>
  implements CreateCartoonPageCubit {}

class MockLatestCartoonBloc
  extends MockBloc<LatestCartoonEvent, LatestCartoonState>
  implements LatestCartoonBloc {}

class MockImageTypeCubit extends MockCubit<ImageType>
  implements ImageTypeCubit {}

class MockPrimaryColorCubit extends MockCubit<PrimaryColor>
  implements PrimaryColorCubit {}

class MockOnboardingCubit extends MockCubit<OnboardingState>
  implements OnboardingCubit {}

class MockSettingsScreenCubit extends MockCubit<SettingsScreen>
  implements SettingsScreenCubit {}

class MockSortByCubit extends MockCubit<SortByMode> implements SortByCubit {}

class MockTabBloc extends MockBloc<TabEvent, AppTab> implements TabBloc {}

class MockTagCubit extends MockCubit<Tag> implements TagCubit {}

class MockThemeCubit extends MockCubit<ThemeMode> implements ThemeCubit {}