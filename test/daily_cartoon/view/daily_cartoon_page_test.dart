import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../helpers/helpers.dart';

class MockDailyCartoonBloc
    extends MockBloc<DailyCartoonEvent, DailyCartoonState>
    implements DailyCartoonBloc {}

void main() {
  group('DailyCartoonScreen', () {
    setupCloudFirestoreMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });
  });

  group('DailyCartoonScreen', () {
    setupCloudFirestoreMocks();

    var dailyCartoonInProgressKey =
        const Key('DailyCartoonScreen_DailyCartoonInProgress');
    var dailyCartoonLoadedKey =
        const Key('DailyCartoonScreen_DailyCartoonLoaded');
    var dailyCartoonFailedKey =
        const Key('DailyCartoonScreen_DailyCartoonFailed');

    var mockPoliticalCartoon = PoliticalCartoon(
        id: '2',
        author: 'Bob',
        date: Timestamp.now(),
        published: Timestamp.now(),
        description: 'Another Mock Political Cartoon',
        unit: Unit.unit1,
        downloadUrl: 'downloadurl');

    late DailyCartoonBloc dailyCartoonBloc;

    setUpAll(() async {
      registerFallbackValue<DailyCartoonState>(DailyCartoonInProgress());
      registerFallbackValue<DailyCartoonEvent>(LoadDailyCartoon());

      await Firebase.initializeApp();

      dailyCartoonBloc = MockDailyCartoonBloc();
    });

    testWidgets(
        'renders widget with Key(\'DailyCartoonScreen_DailyCartoonInProgress\') '
        'when state is DailyCartoonInProgress()', (tester) async {
      var state = DailyCartoonInProgress();
      when(() => dailyCartoonBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: dailyCartoonBloc,
          child: DailyCartoonScreen(),
        ),
      );
      expect(find.byKey(dailyCartoonInProgressKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with Key(\'DailyCartoonScreen_DailyCartoonLoaded\') '
        'when state is DailyCartoonLoaded', (tester) async {
      var state = DailyCartoonLoaded(mockPoliticalCartoon);
      when(() => dailyCartoonBloc.state).thenReturn(state);

      await mockNetworkImagesFor(() => tester.pumpApp(BlocProvider.value(
            value: dailyCartoonBloc,
            child: DailyCartoonScreen(),
          )));

      expect(find.byKey(dailyCartoonLoadedKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with Key(\'DailyCartoonScreen_DailyCartoonFailed\') '
        'when state is DailyCartoonFailed', (tester) async {
      var state = DailyCartoonFailed('Error');
      when(() => dailyCartoonBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: dailyCartoonBloc,
          child: DailyCartoonScreen(),
        ),
      );
      expect(find.byKey(dailyCartoonFailedKey), findsOneWidget);
    });
  });
}
