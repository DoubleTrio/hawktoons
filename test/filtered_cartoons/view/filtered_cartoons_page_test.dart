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

class MockUnitCubit extends MockCubit<Unit> implements UnitCubit {}

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
          units: [Unit.unit1],
          downloadUrl: 'downloadurl')
    ];

    late AllCartoonsBloc allCartoonsBloc;
    late FilteredCartoonsBloc filteredCartoonsBloc;
    late UnitCubit unitCubit;
    late SortByCubit sortByCubit;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late AuthenticationBloc authenticationBloc;

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(AllCartoonsLoading());
      registerFallbackValue<AllCartoonsEvent>(
          LoadAllCartoons(SortByMode.latestPosted));
      registerFallbackValue<FilteredCartoonsState>(FilteredCartoonsLoading());
      registerFallbackValue<FilteredCartoonsEvent>(UpdateFilter(Unit.all));
      registerFallbackValue<AuthenticationEvent>(Logout());
      registerFallbackValue<AuthenticationState>(Authenticated('testing'));
      registerFallbackValue<Unit>(Unit.all);
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);

      await Firebase.initializeApp();

      allCartoonsBloc = MockAllCartoonsBloc();
      filteredCartoonsBloc = MockFilteredCartoonsBloc();
      unitCubit = MockUnitCubit();
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
        BlocProvider.value(value: unitCubit),
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
          FilteredCartoonsLoaded(mockPoliticalCartoonList, Unit.all);
      when(() => filteredCartoonsBloc.state).thenReturn(filteredCartoonsState);
      when(() => unitCubit.state).thenReturn(Unit.all);
      when(() => sortByCubit.state).thenReturn(SortByMode.latestPosted);
      when(() => allCartoonsBloc.state)
          .thenReturn(AllCartoonsLoaded(cartoons: [MockPoliticalCartoon()]));
      when(() => showBottomSheetCubit.state).thenReturn(false);
      when(() => authenticationBloc.state).thenReturn(Authenticated('testing'));

      await mockNetworkImagesFor(
        () => tester.pumpApp(MultiBlocProvider(providers: [
          BlocProvider.value(value: allCartoonsBloc),
          BlocProvider.value(value: filteredCartoonsBloc),
          BlocProvider.value(value: unitCubit),
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
        BlocProvider.value(value: unitCubit),
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
//   () => unitCubit.selectUnit(Unit.all),
//   () => sortByCubit.selectSortBy(SortByMode.latestPosted)
// ]);
//
// var unitFiveButtonKey = const Key('Unit_5_Button');
// await tester.tap(find.byKey(unitFiveButtonKey));
// await tester.pumpAndSettle();
//
// verify(() => unitCubit.selectUnit(Unit.values[5])).called(1);
//
// await tester.tap(find.byKey(unitFiveButtonKey));
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
// verify(() => filteredCartoonsBloc.add(UpdateFilter(Unit.all))).called(1);
// expect(find.byType(FilterPopUp), findsNothing);
