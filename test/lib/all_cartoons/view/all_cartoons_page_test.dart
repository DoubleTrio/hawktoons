import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/auth/auth.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:hawktoons/latest_cartoon/bloc/latest_cartoon.dart';
import 'package:hawktoons/widgets/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  final defaultAllCartoonsState = const AllCartoonsState.initial(
    view: CartoonView.staggered
  );
  group('AllCartoonsPage', () {
    late AllCartoonsBloc allCartoonsBloc;
    late AllCartoonsPageCubit allCartoonsPageCubit;
    late AuthenticationBloc authenticationBloc;
    late AppDrawerCubit appDrawerCubit;
    late LatestCartoonBloc latestCartoonBloc;

    setUpAll(() {
      registerFallbackValue<AllCartoonsPageState>(FakeAllCartoonsPageState());
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<AuthenticationState>(FakeAuthenticationState());
      registerFallbackValue<AuthenticationEvent>(FakeAuthenticationEvent());
      registerFallbackValue<LatestCartoonState>(FakeLatestCartoonState());
      registerFallbackValue<LatestCartoonEvent>(FakeLatestCartoonEvent());
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      allCartoonsPageCubit = MockAllCartoonsPageCubit();
      authenticationBloc = MockAuthenticationBloc();
      appDrawerCubit = MockAppDrawerCubit();
      latestCartoonBloc = MockLatestCartoonBloc();

      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial(view: CartoonView.staggered).copyWith(
          status: CartoonStatus.success,
          cartoons: [mockPoliticalCartoon],
        )
      );

      when(() => allCartoonsPageCubit.state).thenReturn(
        const AllCartoonsPageState.initial()
      );

      when(() => authenticationBloc.state).thenReturn(
        const AuthenticationState(status: AuthenticationStatus.authenticated)
      );
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const AllCartoonsView(),
          allCartoonsBloc: allCartoonsBloc,
          allCartoonsPageCubit: allCartoonsPageCubit,
          authenticationBloc: authenticationBloc,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const AllCartoonsView(),
          mode: ThemeMode.dark,
          allCartoonsBloc: allCartoonsBloc,
          allCartoonsPageCubit: allCartoonsPageCubit,
          authenticationBloc: authenticationBloc,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    testWidgets(
      'renders widget '
      'with Key(\'AllCartoonsPage_AllCartoonsLoading\') '
      'when state is AllCartoonsLoading', (tester) async {
      when(() => allCartoonsBloc.state)
        .thenReturn(defaultAllCartoonsState);
      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
      );
      expect(find.byKey(allCartoonsLoadingKey), findsOneWidget);
    });

    testWidgets(
      'renders a cartoon '
      'when status is CartoonStatus.success', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial(view: CartoonView.staggered).copyWith(
          status: CartoonStatus.success,
          cartoons: [mockPoliticalCartoon]
        )
      );
      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
      );
      expect(find.byType(StaggeredCartoonCard), findsOneWidget);
    });

    testWidgets(
      'renders widget '
      'with Key(\'AllCartoonsPage_AllCartoonsFailed\'); '
      'when state is AllCartoonFailed', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial(view: CartoonView.staggered).copyWith(
          status: CartoonStatus.failure,
        )
      );

      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
      );

      expect(find.byKey(allCartoonsFailedKey), findsOneWidget);
    });

    testWidgets(
      'opens bottom sheet when filter icon is pressed', (tester) async {
      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
      );
      await tester.tap(find.byKey(allCartoonsFilterButtonKey));
      verify(allCartoonsPageCubit.openFilterSheet).called(1);
    });

    testWidgets('opens drawer when menu icon is tapped', (tester) async {
      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
        appDrawerCubit: appDrawerCubit,
        latestCartoonBloc: latestCartoonBloc,
      );
      await tester.tap(find.byKey(allCartoonsMenuButtonKey));
      verify(appDrawerCubit.openDrawer).called(1);
    });

    testWidgets(
      'shows SnackBar when new filter is applied', (tester) async {
      whenListen<AllCartoonsState>(allCartoonsBloc,
        Stream.value(
          const AllCartoonsState.initial(view: CartoonView.staggered).copyWith(
            filters: const CartoonFilters.initial().copyWith(
              tag: Tag.worldHistory
            )
          )
        ),
        initialState: defaultAllCartoonsState,
      );

      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
      );

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Filter applied!'), findsOneWidget);
    });

    testWidgets(
      'does not show SnackBar when old filter is applied', (tester) async {
      whenListen<AllCartoonsState>(allCartoonsBloc,
        Stream.value(defaultAllCartoonsState),
      );

      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
      );

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(SnackBar), findsNothing);
    });

    testWidgets(
      'can open add political image bottom sheet '
      'when user has an admin claim level', (tester) async {
      when(() => authenticationBloc.state).thenReturn(
        const AuthenticationState(
          status: AuthenticationStatus.authenticated,
          claimLevel: 3
        )
      );
      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        allCartoonsPageCubit: allCartoonsPageCubit,
        authenticationBloc: authenticationBloc,
      );

      expect(find.byType(AddFloatingActionButton), findsOneWidget);
      await tester.tap(find.byType(AddFloatingActionButton));
      verify(allCartoonsPageCubit.openCreateCartoonSheet).called(1);
    });
  });
}
