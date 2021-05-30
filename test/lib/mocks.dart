import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/latest_cartoon/latest_cartoon.dart';
import 'package:hawktoons/onboarding/cubits/cubits.dart';
import 'package:hawktoons/onboarding/models/models.dart';
import 'package:hawktoons/settings/cubit/settings_screen_cubit.dart';
import 'package:hawktoons/settings/models/settings_screen.dart';
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

class MockAllCartoonsBloc extends MockBloc<AllCartoonsEvent, AllCartoonsState>
  implements AllCartoonsBloc {}

class MockAuthenticationBloc
  extends MockBloc<AuthenticationEvent, AuthenticationState>
  implements AuthenticationBloc {}

class MockLatestCartoonBloc
  extends MockBloc<LatestCartoonEvent, LatestCartoonState>
  implements LatestCartoonBloc {}

class MockImageTypeCubit extends MockCubit<ImageType>
  implements ImageTypeCubit {}

class MockOnboardingPageCubit extends MockCubit<VisibleOnboardingPage>
  implements OnboardingPageCubit {}

class MockOnboardingSeenCubit extends MockCubit<bool>
  implements OnboardingSeenCubit {}

class MockSelectCartoonCubit extends MockCubit<SelectPoliticalCartoonState>
  implements SelectCartoonCubit {}

class MockScrollHeaderCubit extends MockCubit<bool>
  implements ScrollHeaderCubit {}

class MockSettingsScreenCubit extends MockCubit<SettingsScreen>
  implements SettingsScreenCubit {}

class MockShowBottomSheetCubit extends MockCubit<bool>
  implements ShowBottomSheetCubit {}

class MockSortByCubit extends MockCubit<SortByMode> implements SortByCubit {}

class MockTabBloc extends MockBloc<TabEvent, AppTab> implements TabBloc {}

class MockTagCubit extends MockCubit<Tag> implements TagCubit {}

class MockThemeCubit extends MockCubit<ThemeMode> implements ThemeCubit {}