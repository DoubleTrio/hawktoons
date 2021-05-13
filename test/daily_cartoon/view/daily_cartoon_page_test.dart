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
import '../../mocks.dart';
import '../../fakes.dart';

const dailyCartoonInProgressKey =
  Key('DailyCartoonScreen_DailyCartoonInProgress');
const dailyCartoonLoadedKey =
  Key('DailyCartoonScreen_DailyCartoonLoaded');
const dailyCartoonFailedKey =
  Key('DailyCartoonScreen_DailyCartoonFailed');

void main() {
  group('DailyCartoonScreen', () {
    late DailyCartoonBloc dailyCartoonBloc;

    Widget wrapper(Widget child) {
      return MultiBlocProvider(providers: [
        BlocProvider.value(value: dailyCartoonBloc),
      ], child: child);
    }

    setUpAll(() async {
      registerFallbackValue<DailyCartoonState>(FakeDailyCartoonState());
      registerFallbackValue<DailyCartoonEvent>(FakeDailyCartoonEvent());
      dailyCartoonBloc = MockDailyCartoonBloc();
    });

    testWidgets(
        'renders widget with '
        'Key(\'DailyCartoonScreen_DailyCartoonInProgress\') '
        'when state is DailyCartoonInProgress()', (tester) async {
      var state = DailyCartoonInProgress();
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(
        wrapper(DailyCartoonScreen())
      );
      expect(find.byKey(dailyCartoonInProgressKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with Key(\'DailyCartoonScreen_DailyCartoonLoaded\') '
        'when state is DailyCartoonLoaded', (tester) async {
      var state = DailyCartoonLoaded(mockPoliticalCartoon);
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await mockNetworkImagesFor(() => tester.pumpApp(
        wrapper(DailyCartoonScreen())
      ));
      expect(find.byKey(dailyCartoonLoadedKey), findsOneWidget);
    });

    testWidgets(
        'renders widget with Key(\'DailyCartoonScreen_DailyCartoonFailed\') '
        'when state is DailyCartoonFailed', (tester) async {
      var state = DailyCartoonFailed('Error');
      when(() => dailyCartoonBloc.state).thenReturn(state);
      await tester.pumpApp(wrapper(DailyCartoonScreen()));
      expect(find.byKey(dailyCartoonFailedKey), findsOneWidget);
    });
  });
}
