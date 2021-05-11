import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:history_app/filtered_cartoons/filtered_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../helpers/helpers.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

class MockAllCartoonsBloc extends MockBloc<AllCartoonsEvent, AllCartoonsState>
    implements AllCartoonsBloc {}

class MockFilteredCartoonsBloc
    extends MockBloc<FilteredCartoonsEvent, FilteredCartoonsState>
    implements FilteredCartoonsBloc {}

class MockTagCubit extends MockCubit<Tag> implements TagCubit {}

class MockSortByCubit extends MockCubit<SortByMode> implements SortByCubit {}

class MockShowBottomSheetCubit extends MockCubit<bool>
    implements ShowBottomSheetCubit {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  group('FilteredCartoonsPage', () {
    setupCloudFirestoreMocks();

    var filteredCartoonsLoadingKey =
        const Key('FilteredCartoonsPage_FilteredCartoonsLoading');
    var filteredCartoonsLoadedKey =
        const Key('FilteredCartoonsPage_FilteredCartoonsLoaded');
    var filteredCartoonsFailedKey =
        const Key('FilteredCartoonsPage_FilteredCartoonsFailed');

    var mockPoliticalCartoonList = [
      PoliticalCartoon(
          id: '2',
          author: 'Bob',
          date: Timestamp.now(),
          published: Timestamp.now(),
          description: 'Another Mock Political Cartoon',
          tags: [Tag.tag1],
          downloadUrl: 'downloadurl')
    ];

    late AllCartoonsBloc allCartoonsBloc;
    late FilteredCartoonsBloc filteredCartoonsBloc;
    late TagCubit tagCubit;
    late SortByCubit sortByCubit;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late AuthenticationBloc authenticationBloc;

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(AllCartoonsLoading());
      registerFallbackValue<AllCartoonsEvent>(
          LoadAllCartoons(SortByMode.latestPosted));
      registerFallbackValue<FilteredCartoonsState>(FilteredCartoonsLoading());
      registerFallbackValue<FilteredCartoonsEvent>(UpdateFilter(Tag.all));
      registerFallbackValue<AuthenticationEvent>(Logout());
      registerFallbackValue<AuthenticationState>(Authenticated('testing'));
      registerFallbackValue<Tag>(Tag.all);
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);

      await Firebase.initializeApp();

      allCartoonsBloc = MockAllCartoonsBloc();
      filteredCartoonsBloc = MockFilteredCartoonsBloc();
      tagCubit = MockTagCubit();
      sortByCubit = MockSortByCubit();
      showBottomSheetCubit = MockShowBottomSheetCubit();
      authenticationBloc = MockAuthenticationBloc();
    });

    testWidgets(
        'renders widget '
        'with Key(\'FilteredCartoonsPage_FilteredCartoonsLoading\') '
        'when state is FilteredCartoonsLoading', (tester) async {
      var filteredCartoonsState = FilteredCartoonsLoading();
      when(() => filteredCartoonsBloc.state).thenReturn(filteredCartoonsState);

      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(value: tagCubit),
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: filteredCartoonsBloc),
        BlocProvider.value(value: sortByCubit),
        BlocProvider.value(value: showBottomSheetCubit)
      ], child: FilteredCartoonsScreen()));

      expect(find.byKey(filteredCartoonsLoadingKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with '
        'Key(\'FilteredCartoonsPage_FilteredCartoonsLoaded\') '
        'when state is FilteredCartoonsLoaded', (tester) async {
      var filteredCartoonsState =
          FilteredCartoonsLoaded(mockPoliticalCartoonList, Tag.all);
      when(() => filteredCartoonsBloc.state).thenReturn(filteredCartoonsState);
      when(() => tagCubit.state).thenReturn(Tag.all);
      when(() => sortByCubit.state).thenReturn(SortByMode.latestPosted);
      when(() => allCartoonsBloc.state)
          .thenReturn(AllCartoonsLoaded(cartoons: [MockPoliticalCartoon()]));
      when(() => showBottomSheetCubit.state).thenReturn(false);
      when(() => authenticationBloc.state).thenReturn(Authenticated('testing'));

      await mockNetworkImagesFor(
        () => tester.pumpApp(MultiBlocProvider(providers: [
          BlocProvider.value(value: allCartoonsBloc),
          BlocProvider.value(value: filteredCartoonsBloc),
          BlocProvider.value(value: tagCubit),
          BlocProvider.value(value: sortByCubit),
          BlocProvider.value(value: showBottomSheetCubit),
          BlocProvider.value(value: authenticationBloc)
        ], child: FilteredCartoonsScreen())),
      );

      var filterIconKey = const Key('FilteredCartoonsPage_FilterIcon');
      expect(find.byKey(filteredCartoonsLoadedKey), findsOneWidget);
      await tester.tap(find.byKey(filterIconKey));
      verify(showBottomSheetCubit.openSheet).called(1);
    });

    testWidgets(
        'renders widget '
        'with Key(\'FilteredCartoonsPage_FilteredCartoonsFailed\'); '
        'when state is FilteredCartoonFailed', (tester) async {
      var filteredCartoonsState = FilteredCartoonsFailed('Error');
      when(() => filteredCartoonsBloc.state).thenReturn(filteredCartoonsState);

      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(value: tagCubit),
        BlocProvider.value(value: allCartoonsBloc),
        BlocProvider.value(value: filteredCartoonsBloc),
        BlocProvider.value(value: sortByCubit),
        BlocProvider.value(value: showBottomSheetCubit)
      ], child: FilteredCartoonsScreen()));

      expect(find.byKey(filteredCartoonsFailedKey), findsOneWidget);
    });
  });
}

// await tester.pumpAndSettle();
//
// expect(find.byType(FilterPopUp), findsOneWidget);
//
// var resetButtonKey = const Key('ButtonRowHeader_ResetButton');
// await tester.tap(find.byKey(resetButtonKey));
//
// verifyInOrder([
//   () => tagCubit.selectTag(Tag.all),
//   () => sortByCubit.selectSortBy(SortByMode.latestPosted)
// ]);
//
// var tagFiveButtonKey = const Key('Tag_5_Button');
// await tester.tap(find.byKey(tagFiveButtonKey));
// await tester.pumpAndSettle();
//
// verify(() => tagCubit.selectTag(Tag.values[5])).called(1);
//
// await tester.tap(find.byKey(tagFiveButtonKey));
// await tester.pumpAndSettle();
//
// var sortByModeKey = const Key('SortByMode_2');
// await tester.tap(find.descendant(
//     of: find.byKey(sortByModeKey), matching: find.byType(InkWell)));
// await tester.pumpAndSettle();
//
// verify(() => sortByCubit.selectSortBy(SortByMode.values[2])).called(1);
//
// var applyFilterButtonKey = const Key('ButtonRowHeader_ApplyFilterButton');
// await tester.tap(find.byKey(applyFilterButtonKey));
// await tester.pumpAndSettle();
//
// verify(() => filteredCartoonsBloc.add(UpdateFilter(Tag.all))).called(1);
// expect(find.byType(FilterPopUp), findsNothing);
