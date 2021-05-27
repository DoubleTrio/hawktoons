import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/daily_cartoon/daily_cartoon.dart';
import 'package:hawktoons/home/blocs/blocs.dart';
import 'package:hawktoons/onboarding/cubits/cubits.dart';
import 'package:hawktoons/onboarding/models/models.dart';
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

class MockCartoonRepository extends Mock
  implements FirestorePoliticalCartoonRepository {}

class MockFirebaseUserRepository extends Mock
  implements FirebaseUserRepository {}

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

class MockAuthenticationBloc
  extends MockBloc<AuthenticationEvent, AuthenticationState>
  implements AuthenticationBloc {}

class MockOnboardingSeenCubit extends MockCubit<bool>
  implements OnboardingSeenCubit {}

class MockAllCartoonsBloc extends MockBloc<AllCartoonsEvent, AllCartoonsState>
  implements AllCartoonsBloc {}

class MockTagCubit extends MockCubit<Tag> implements TagCubit {}

class MockSortByCubit extends MockCubit<SortByMode> implements SortByCubit {}

class MockShowBottomSheetCubit extends MockCubit<bool>
  implements ShowBottomSheetCubit {}

class MockScrollHeaderCubit extends MockCubit<bool>
  implements ScrollHeaderCubit {}

class MockTabBloc extends MockBloc<TabEvent, AppTab> implements TabBloc {}

class MockDailyCartoonBloc
  extends MockBloc<DailyCartoonEvent, DailyCartoonState>
  implements DailyCartoonBloc {}

class MockThemeCubit extends MockCubit<ThemeMode> implements ThemeCubit {}

class MockSelectCartoonCubit extends MockCubit<SelectPoliticalCartoonState>
  implements SelectCartoonCubit {}

class MockImageTypeCubit extends MockCubit<ImageType>
  implements ImageTypeCubit {}

class MockOnboardingPageCubit extends MockCubit<VisibleOnboardingPage>
  implements OnboardingPageCubit {}