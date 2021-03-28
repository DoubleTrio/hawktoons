import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';

import '../../helpers/helpers.dart';

class MockDailyCartoonBloc
    extends MockBloc<DailyCartoonEvent, DailyCartoonState>
    implements DailyCartoonBloc {}

void main() {
  group('DailyCartoonPage', () {
    testWidgets('renders DailyCartoonView', (tester) async {
      await tester.pumpApp(const DailyCartoonPage());
      await tester.pumpAndSettle();
      expect(find.byType(DailyCartoonView), findsOneWidget);
    });
  });

  group('DailyCartoonView', () {
    var loadDailyCartoonTextKey =
        const Key('dailyCartoonView_dailyCartoonLoaded_text');
    var loadDailyCartoonErrorTextKey =
        const Key('dailyCartoonView_dailyCartoonFailure_text');

    var mockDailyPoliticalCartoon = DailyCartoon(
        id: '2',
        image: 'insert-image-uri-another',
        author: 'Bob',
        date: '11-20-2020',
        description: 'Another Mock Political Cartoon');

    late DailyCartoonBloc dailyCartoonBloc;

    setUpAll(() {
      registerFallbackValue<DailyCartoonState>(DailyCartoonInProgress());
      registerFallbackValue<DailyCartoonEvent>(LoadDailyCartoon());
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
      var state = DailyCartoonLoaded(dailyCartoon: mockDailyPoliticalCartoon);
      when(() => dailyCartoonBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: dailyCartoonBloc,
          child: DailyCartoonView(),
        ),
      );
      expect(find.byKey(loadDailyCartoonTextKey), findsOneWidget);
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
