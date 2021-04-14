import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
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
          unit: Unit.unit1,
          downloadUrl: 'downloadurl')
    ];

    late AllCartoonsBloc allCartoonsBloc;
    late FilteredCartoonsBloc filteredCartoonsBloc;
    late UnitCubit unitCubit;

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(AllCartoonsLoading());
      registerFallbackValue<AllCartoonsEvent>(LoadAllCartoons());
      registerFallbackValue<FilteredCartoonsState>(FilteredCartoonsLoading());
      registerFallbackValue<FilteredCartoonsEvent>(UpdateFilter(Unit.all));
      registerFallbackValue<Unit>(Unit.all);

      await Firebase.initializeApp();

      allCartoonsBloc = MockAllCartoonsBloc();
      filteredCartoonsBloc = MockFilteredCartoonsBloc();
      unitCubit = MockUnitCubit();
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
        BlocProvider.value(value: filteredCartoonsBloc)
      ], child: FilteredCartoonsPage()));

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

      await mockNetworkImagesFor(
        () => tester.pumpApp(MultiBlocProvider(providers: [
          BlocProvider.value(value: allCartoonsBloc),
          BlocProvider.value(value: filteredCartoonsBloc),
          BlocProvider.value(value: unitCubit),
        ], child: FilteredCartoonsPage())),
      );

      var filterIconKey = const Key('FilteredCartoonsPage_FilterIcon');
      expect(find.byKey(filteredCartoonsLoadedKey), findsOneWidget);
      await tester.tap(find.byKey(filterIconKey));
      await tester.pumpAndSettle();

      expect(find.byType(FilterPopUp), findsOneWidget);

      // Unit.all not included, therefore it is one less unit
      expect(find.byType(UnitTile), findsNWidgets(Unit.values.length - 1));

      var unitFiveTileKey = const Key('Unit_5_Tile');
      await tester.tap(find.byKey(unitFiveTileKey));
      await tester.pumpAndSettle();

      verify(() => unitCubit.selectUnit(Unit.unit5)).called(1);

      await tester.tap(find.byKey(unitFiveTileKey));
      await tester.pumpAndSettle();

      var applyFilterButtonKey = const Key('FilterPopUp_ApplyFilterButton');
      await tester.tap(find.byKey(applyFilterButtonKey));
      await tester.pumpAndSettle();
      verify(() => filteredCartoonsBloc.add(UpdateFilter(Unit.all))).called(1);
      expect(find.byType(FilterPopUp), findsNothing);
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
        BlocProvider.value(value: filteredCartoonsBloc)
      ], child: FilteredCartoonsPage()));

      expect(find.byKey(filteredCartoonsFailedKey), findsOneWidget);

      // TODO: add tests for widgets
    });
  });
}
