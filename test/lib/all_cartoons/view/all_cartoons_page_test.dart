import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import 'package:hawktoons/latest_cartoon/bloc/latest_cartoon.dart';
import 'package:hawktoons/widgets/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('AllCartoonsPage', () {
    late AllCartoonsBloc allCartoonsBloc;
    late AppDrawerCubit appDrawerCubit;
    late LatestCartoonBloc latestCartoonBloc;
    late ShowBottomSheetCubit showBottomSheetCubit;
    late ScrollHeaderCubit scrollHeaderCubit;

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<LatestCartoonState>(FakeLatestCartoonState());
      registerFallbackValue<LatestCartoonEvent>(FakeLatestCartoonEvent());
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      appDrawerCubit = MockAppDrawerCubit();
      latestCartoonBloc = MockLatestCartoonBloc();
      showBottomSheetCubit = MockShowBottomSheetCubit();
      scrollHeaderCubit = MockScrollHeaderCubit();

      when(() => scrollHeaderCubit.state).thenReturn(false);
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: [mockPoliticalCartoon],
        )
      );
    });

    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const AllCartoonsView(),
          allCartoonsBloc: allCartoonsBloc,
          scrollHeaderCubit: scrollHeaderCubit,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const AllCartoonsView(),
          mode: ThemeMode.dark,
          allCartoonsBloc: allCartoonsBloc,
          scrollHeaderCubit: scrollHeaderCubit,
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
        .thenReturn(const AllCartoonsState.initial());
      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        scrollHeaderCubit: scrollHeaderCubit,
      );
      expect(find.byKey(allCartoonsLoadingKey), findsOneWidget);
    });

    testWidgets(
      'renders a cartoon'
      'when status is CartoonStatus.success', (tester) async {
      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        scrollHeaderCubit: scrollHeaderCubit,
      );
      expect(find.byType(StaggeredCartoonCard), findsOneWidget);
    });

    testWidgets(
      'renders widget '
      'with Key(\'AllCartoonsPage_AllCartoonsFailed\'); '
      'when state is AllCartoonFailed', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.failure,
        )
      );

      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        scrollHeaderCubit: scrollHeaderCubit,
      );

      expect(find.byKey(allCartoonsFailedKey), findsOneWidget);
    });

    testWidgets(
      'opens bottom sheet when filter icon is pressed', (tester) async {
      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        scrollHeaderCubit: scrollHeaderCubit,
        showBottomSheetCubit: showBottomSheetCubit,
      );
      await tester.tap(find.byKey(allCartoonsFilterButtonKey));
      verify(showBottomSheetCubit.openSheet).called(1);
    });

    testWidgets('opens drawer when menu icon is tapped', (tester) async {
      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        appDrawerCubit: appDrawerCubit,
        latestCartoonBloc: latestCartoonBloc,
        scrollHeaderCubit: scrollHeaderCubit,
      );
      await tester.tap(find.byKey(allCartoonsMenuButtonKey));
      verify(appDrawerCubit.openDrawer).called(1);
    });

    testWidgets(
      'shows SnackBar when new filter is applied', (tester) async {
      whenListen<AllCartoonsState>(allCartoonsBloc,
        Stream.value(
          const AllCartoonsState.initial().copyWith(
            filters: const CartoonFilters.initial().copyWith(
              tag: Tag.worldHistory
            )
          )
        ),
        initialState: const AllCartoonsState.initial(),
      );

      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        scrollHeaderCubit: scrollHeaderCubit,
      );

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Filter applied!'), findsOneWidget);
    });

    testWidgets(
      'does not show SnackBar when old filter is applied', (tester) async {
      whenListen<AllCartoonsState>(allCartoonsBloc,
        Stream.value(const AllCartoonsState.initial()),
      );

      await tester.pumpApp(
        const AllCartoonsView(),
        allCartoonsBloc: allCartoonsBloc,
        scrollHeaderCubit: scrollHeaderCubit,
      );

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(SnackBar), findsNothing);
    });
  });
}
