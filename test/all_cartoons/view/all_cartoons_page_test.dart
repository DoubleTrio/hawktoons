import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../helpers/helpers.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

class MockAllCartoonsBloc extends MockBloc<AllCartoonsEvent, AllCartoonsState>
    implements AllCartoonsBloc {}

void main() {
  group('AllCartoonsPage', () {
    setupCloudFirestoreMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('renders AllCartoonsView', (tester) async {
      await tester.pumpApp(AllCartoonsPage());
      expect(find.byType(AllCartoonsView), findsOneWidget);
    });
  });

  group('AllCartoonsView', () {
    setupCloudFirestoreMocks();

    var allCartoonsInProgressKey =
        const Key('AllCartoonsView_AllCartoonsInProgress');
    var allCartoonsLoadedKey = const Key('AllCartoonsView_AllCartoonsLoaded');
    var allCartoonsLoadFailureKey =
        const Key('AllCartoonsView_AllCartoonsLoadFailure');

    var mockPoliticalCartoonList = [
      PoliticalCartoon(
          id: '2',
          author: 'Bob',
          date: Timestamp.now(),
          description: 'Another Mock Political Cartoon',
          unitId: UnitId.unit1,
          downloadUrl: 'downloadurl')
    ];

    late AllCartoonsBloc allCartoonsBloc;

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(AllCartoonsInProgress());
      registerFallbackValue<AllCartoonsEvent>(LoadAllCartoons());

      await Firebase.initializeApp();

      allCartoonsBloc = MockAllCartoonsBloc();
    });

    testWidgets(
        'renders widget with Key(\'AllCartoonsView_AllCartoonsInProgress\') '
        'when state is AllCartoonsInProgress', (tester) async {
      var state = AllCartoonsInProgress();
      when(() => allCartoonsBloc.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: allCartoonsBloc,
          child: AllCartoonsView(),
        ),
      );
      expect(find.byKey(allCartoonsInProgressKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with Key(\'AllCartoonsView_AllCartoonsLoaded\') '
        'when state is AllCartoonsLoaded', (tester) async {
      var state = AllCartoonsLoaded(cartoons: mockPoliticalCartoonList);
      when(() => allCartoonsBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: allCartoonsBloc,
          child: AllCartoonsView(),
        ),
      );

      expect(find.byKey(allCartoonsLoadedKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with Key(\'AllCartoonsView_AllCartoonsLoadFailure\'); '
        'when state is AllCartoonsLoadFailure', (tester) async {
      var state = AllCartoonsLoadFailure('Error');
      when(() => allCartoonsBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: allCartoonsBloc,
          child: AllCartoonsView(),
        ),
      );

      expect(find.byKey(allCartoonsLoadFailureKey), findsOneWidget);
    });
  });
}
