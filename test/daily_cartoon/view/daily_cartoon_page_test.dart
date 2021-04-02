import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../helpers/helpers.dart';

class MockDailyCartoonBloc
    extends MockBloc<DailyCartoonEvent, DailyCartoonState>
    implements DailyCartoonBloc {}

void main() {
  group('DailyCartoonPage', () {
    setupCloudFirestoreMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('renders DailyCartoonView', (tester) async {
      await tester.pumpApp(const DailyCartoonPage());
      expect(find.byType(DailyCartoonView), findsOneWidget);
      expect(find.byType(PoliticalCartoonCardLoader), findsOneWidget);
    });
  });

  group('DailyCartoonView', () {
    setupCloudFirestoreMocks();
    var fetchDailyCartoonCardKey =
        const Key('dailyCartoonView_dailyCartoonLoaded_card');

    var loadDailyCartoonErrorTextKey =
        const Key('dailyCartoonView_dailyCartoonFailure_text');

    var mockPoliticalCartoon = PoliticalCartoon(
        id: '2',
        image: 'insert-image-uri-another',
        author: 'Bob',
        date: Timestamp.now(),
        description: 'Another Mock Political Cartoon');

    late DailyCartoonBloc dailyCartoonBloc;

    setUpAll(() async {
      registerFallbackValue<DailyCartoonState>(DailyCartoonInProgress());
      registerFallbackValue<DailyCartoonEvent>(LoadDailyCartoon());

      TestWidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      dailyCartoonBloc = MockDailyCartoonBloc();
    });

    testWidgets(
        'renders CircularProgressIndicator() '
        'when state is DailyCartoonInProgress()', (tester) async {
      var state = DailyCartoonInProgress();
      when(() => dailyCartoonBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: dailyCartoonBloc,
          child: DailyCartoonView(),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets(
        'renders daily political cartoon '
        'when state is DailyCartoonLoaded()', (tester) async {
      var state = DailyCartoonLoaded(dailyCartoon: mockPoliticalCartoon);
      when(() => dailyCartoonBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: dailyCartoonBloc,
          child: DailyCartoonView(),
        ),
      );
      expect(find.byKey(fetchDailyCartoonCardKey), findsOneWidget);
    });

    testWidgets(
        'renders error text '
        'when state is DailyCartoonFailure()', (tester) async {
      var state = DailyCartoonFailure();
      when(() => dailyCartoonBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: dailyCartoonBloc,
          child: DailyCartoonView(),
        ),
      );
      expect(find.byKey(loadDailyCartoonErrorTextKey), findsOneWidget);
    });
  });
}
