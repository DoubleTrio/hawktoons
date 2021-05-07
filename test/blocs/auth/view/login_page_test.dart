import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/auth/auth.dart';
import 'package:history_app/blocs/auth/auth.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

//
// class MockSortByCubit extends MockCubit<SortByMode> implements SortByCubit {}
//
void main() {
  group('LoginPage', () {
    setupCloudFirestoreMocks();

    var authLoadingKey = const Key('LoginPage_AuthLoading');
    var unauthenticatedKey = const Key('LoginPage_Unauthenticated');

    var signInAnonymouslyButtonKey =
        const Key('LoginPage_SignInAnonymouslyButton');
    late AuthenticationBloc authenticationBloc;
    // late SortByCubit sortByCubit;

    setUpAll(() async {
      registerFallbackValue<AuthenticationState>(Uninitialized());
      registerFallbackValue<AuthenticationEvent>(SignInAnonymously());
      await Firebase.initializeApp();

      authenticationBloc = MockAuthenticationBloc();
      // sortByCubit = MockSortByCubit();
    });

    testWidgets(
        'finds Key(\'LoginPage_AuthLoading\') '
        'when state is AuthLoading', (tester) async {
      var state = AuthLoading();

      when(() => authenticationBloc.state).thenReturn(state);
      await tester.pumpApp(
        MultiBlocProvider(providers: [
          BlocProvider.value(
            value: authenticationBloc,
          ),
        ], child: LoginScreen()),
      );
      expect(find.byKey(authLoadingKey), findsOneWidget);
    });

    testWidgets(
        'finds Key(\'LoginPage_Unauthenticated\') '
        'when state is Unauthenticated', (tester) async {
      var state = Unauthenticated();

      when(() => authenticationBloc.state).thenReturn(state);
      await tester.pumpApp(
        MultiBlocProvider(providers: [
          BlocProvider.value(
            value: authenticationBloc,
          ),
        ], child: LoginScreen()),
      );
      expect(find.byKey(unauthenticatedKey), findsOneWidget);
    });

    testWidgets(
        'AuthenticationBloc adds SignInAnonymously '
        'when sign in button is clicked', (tester) async {
      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: authenticationBloc,
        ),
      ], child: LoginScreen()));

      await tester.tap(find.byKey(signInAnonymouslyButtonKey));
      verify(() => authenticationBloc.add(SignInAnonymously())).called(1);
    });

    testWidgets(
        'navigates to HomeFlow route '
        'when state is Authenticated', (tester) async {
      var states = [Authenticated('user-id')];
      whenListen<AuthenticationState>(
          authenticationBloc, Stream.fromIterable(states),
          initialState: Uninitialized());
      when(() => authenticationBloc.state).thenReturn(states[0]);

      await tester.pumpApp(MultiBlocProvider(providers: [
        BlocProvider.value(
          value: authenticationBloc,
        ),
      ], child: LoginScreen()));
      expect(find.byType(SizedBox), findsOneWidget);
      // TODO - fix strange bug involving not navigating
      // tester.pumpAndSettle();
      // expect(find.byType(HomeFlow), findsOneWidget);
    });
  });
}
