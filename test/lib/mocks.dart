import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:history_app/home/blocs/blocs.dart';
import 'package:history_app/onboarding/cubits/cubits.dart';
import 'package:history_app/theme/theme.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var mockFilter = const CartoonFilters(
  sortByMode: SortByMode.latestPosted,
  imageType: ImageType.all,
  tag: Tag.all
);

var mockPoliticalCartoon = PoliticalCartoon(
  id: '2',
  author: 'Bob',
  timestamp: Timestamp.now(),
  published: Timestamp.now(),
  description: 'Another Mock Political Cartoon',
  tags: [Tag.tag1],
  downloadUrl: 'downloadurl',
  type: ImageType.cartoon
);

class MockPoliticalCartoonRepository extends Mock implements
  FirestorePoliticalCartoonRepository {}

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
