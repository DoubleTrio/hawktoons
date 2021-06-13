import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

void main() {
  initHydratedBloc();
  group('AuthFlow', () {
    late FirestorePoliticalCartoonRepository cartoonRepository;
    late AppearancesCubit appearancesCubit;
    late AuthenticationBloc authenticationBloc;

    PoliticalCartoon mockCartoon = MockPoliticalCartoon();

    setUpAll(() {
      registerFallbackValue<AppearancesState>(FakeAppearancesState());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<ThemeMode>(ThemeMode.light);
    });

    setUp(() {
      appearancesCubit = MockAppearancesCubit();
      cartoonRepository = MockCartoonRepository();
      authenticationBloc = MockAuthenticationBloc();

      when(() => appearancesCubit.state).thenReturn(
        const AppearancesState.initial()
      );
      when(() => cartoonRepository.politicalCartoons(
        sortByMode: SortByMode.latestPosted,
        imageType: ImageType.all,
        tag: Tag.all,
        limit: 15,
      )).thenAnswer((_) async => [mockPoliticalCartoon]);

      when(cartoonRepository.getLatestPoliticalCartoon).thenAnswer(
        (_) => Stream.value(mockCartoon)
      );

      // when(() => themeCubit.state).thenReturn(ThemeMode.light);
    });

    group('LoginPage', () {
      testWidgets('shows LoginPage', (tester) async {
        when(() => authenticationBloc.state).thenReturn(
          const AuthenticationState.uninitialized()
        );
        await tester.pumpApp(
          const AuthFlow(),
          authenticationBloc: authenticationBloc,
        );
        expect(find.byType(LoginView), findsOneWidget);
      });
    });

    group('DrawerStackView', () {
      testWidgets('shows DrawerStackView', (tester) async {
        when(() => authenticationBloc.state)
          .thenReturn(AuthenticationState.authenticated(FakeUser()));
        await tester.pumpApp(
          const AuthFlow(),
          cartoonRepository: cartoonRepository,
          appearancesCubit: appearancesCubit,
          authenticationBloc: authenticationBloc,
        );
        expect(find.byType(DrawerStackView), findsOneWidget);
      });
    });
  });
}
