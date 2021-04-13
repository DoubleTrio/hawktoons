import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
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

    var allCartoonsLoadingKey = const Key('AllCartoonsView_AllCartoonsLoading');
    var allCartoonsLoadedKey = const Key('AllCartoonsView_AllCartoonsLoaded');
    var allCartoonsFailedKey = const Key('AllCartoonsView_AllCartoonsFailed');

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

    setUpAll(() async {
      registerFallbackValue<AllCartoonsState>(AllCartoonsLoading());
      registerFallbackValue<AllCartoonsEvent>(LoadAllCartoons());

      await Firebase.initializeApp();

      allCartoonsBloc = MockAllCartoonsBloc();
    });

    testWidgets(
        'renders widget with Key(\'AllCartoonsView_AllCartoonsLoading\') '
        'when state is AllCartoonsLoading', (tester) async {
      var state = AllCartoonsLoading();
      when(() => allCartoonsBloc.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: allCartoonsBloc,
          child: AllCartoonsView(),
        ),
      );
      expect(find.byKey(allCartoonsLoadingKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with Key(\'AllCartoonsView_AllCartoonsLoaded\') '
        'when state is AllCartoonsLoaded', (tester) async {
      var state = AllCartoonsLoaded(cartoons: mockPoliticalCartoonList);
      when(() => allCartoonsBloc.state).thenReturn(state);

      await mockNetworkImagesFor(() => tester.pumpApp(
            BlocProvider.value(
              value: allCartoonsBloc,
              child: AllCartoonsView(),
            ),
          ));

      expect(find.byKey(allCartoonsLoadedKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with Key(\'AllCartoonsView_AllCartoonsFailed\'); '
        'when state is AllCartoonsFailed', (tester) async {
      var state = AllCartoonsFailed('Error');
      when(() => allCartoonsBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: allCartoonsBloc,
          child: AllCartoonsView(),
        ),
      );

      expect(find.byKey(allCartoonsFailedKey), findsOneWidget);
    });
  });
}
