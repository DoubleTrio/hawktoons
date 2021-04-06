import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/app/app.dart';
import 'package:history_app/auth/auth.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  group('AuthBlocBuilder', () {
    setupCloudFirestoreMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });
  });

  group('AuthBlocBuilder', () {
    setupCloudFirestoreMocks();
    var authenticatedKey = const Key('dailyCartoonPage_Authenticated');

    var unauthenticatedKey = const Key('dailyCartoonPage_Unauthenticated');

    var uninitializedKey = const Key('dailyCartoonPage_Uninitialized');

    late AuthenticationBloc authenticationBloc;

    setUpAll(() async {
      registerFallbackValue<AuthenticationState>(Uninitialized());
      registerFallbackValue<AuthenticationEvent>(AppStarted());

      await Firebase.initializeApp();

      authenticationBloc = MockAuthenticationBloc();
    });

    testWidgets(
        'finds Key(\'dailyCartoonPage_Unauthenticated\')'
        'when state is Uninitialized', (tester) async {
      var state = Uninitialized();
      when(() => authenticationBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: authenticationBloc,
          child: AuthBlocBuilder(),
        ),
      );
      expect(find.byKey(uninitializedKey), findsOneWidget);
    });
    testWidgets(
        'finds Key(\'dailyCartoonPage_Authenticated\')'
        'when state is Authenticated', (tester) async {
      var state = Authenticated('user-id');
      when(() => authenticationBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: authenticationBloc,
          child: AuthBlocBuilder(),
        ),
      );
      expect(find.byKey(authenticatedKey), findsOneWidget);
    });
    testWidgets(
        'finds Key(\'dailyCartoonPage_Unauthenticated\')'
        'when state is Unauthenticated', (tester) async {
      var state = Unauthenticated();
      when(() => authenticationBloc.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: authenticationBloc,
          child: AuthBlocBuilder(),
        ),
      );
      expect(find.byKey(unauthenticatedKey), findsOneWidget);
    });
  });
}
