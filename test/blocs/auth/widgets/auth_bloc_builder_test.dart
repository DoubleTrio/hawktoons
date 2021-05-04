import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/app/app.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../../helpers/helpers.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockSortByCubit extends MockCubit<SortByMode> implements SortByCubit {}

void main() {
  group('AuthBlocBuilder', () {
    setupCloudFirestoreMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });
  });

  group('AuthBlocBuilder', () {
    setupCloudFirestoreMocks();

    var authenticatedKey = const Key('DailyCartoonScreen_Authenticated');
    var unauthenticatedKey = const Key('DailyCartoonScreen_Unauthenticated');
    var uninitializedKey = const Key('DailyCartoonScreen_Uninitialized');

    late AuthenticationBloc authenticationBloc;
    late SortByCubit sortByCubit;

    setUpAll(() async {
      registerFallbackValue<AuthenticationState>(Uninitialized());
      registerFallbackValue<AuthenticationEvent>(SignInAnonymously());
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);
      await Firebase.initializeApp();

      authenticationBloc = MockAuthenticationBloc();
      sortByCubit = MockSortByCubit();
    });

    testWidgets(
        'finds Key(\'DailyCartoonScreen_Unauthenticated\')'
        'when state is Uninitialized', (tester) async {
      var state = Uninitialized();

      when(() => authenticationBloc.state).thenReturn(state);
      when(() => sortByCubit.state).thenReturn(SortByMode.latestPosted);
      await tester.pumpApp(
        MultiBlocProvider(providers: [
          BlocProvider.value(
            value: authenticationBloc,
          ),
          BlocProvider.value(
            value: sortByCubit,
          )
        ], child: AuthBlocBuilder()),
      );
      expect(find.byKey(uninitializedKey), findsOneWidget);
    });
    testWidgets(
        'finds Key(\'DailyCartoonScreen_Authenticated\')'
        'when state is Authenticated', (tester) async {
      var state = Authenticated('user-id');

      when(() => authenticationBloc.state).thenReturn(state);
      when(() => sortByCubit.state).thenReturn(SortByMode.latestPosted);
      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: authenticationBloc,
        ),
        BlocProvider.value(
          value: sortByCubit,
        )
      ], child: AuthBlocBuilder()));
      expect(find.byKey(authenticatedKey), findsOneWidget);
    });
    testWidgets(
        'finds Key(\'DailyCartoonScreen_Unauthenticated\')'
        'when state is Unauthenticated', (tester) async {
      var state = Unauthenticated();

      when(() => authenticationBloc.state).thenReturn(state);
      when(() => sortByCubit.state).thenReturn(SortByMode.latestPosted);
      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: authenticationBloc,
        ),
        BlocProvider.value(
          value: sortByCubit,
        )
      ], child: AuthBlocBuilder()));
      expect(find.byKey(unauthenticatedKey), findsOneWidget);
    });
  });
}
