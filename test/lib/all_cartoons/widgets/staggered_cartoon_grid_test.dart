import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

const _staggeredGridLoadingMoreKey =
  Key('StaggeredCartoonGrid_LoadingMoreIndicator');

void main() {
  group('StaggeredCartoonGrid', () {
    late AllCartoonsBloc allCartoonsBloc;
    late ScrollHeaderCubit scrollHeaderCubit;
    late SelectCartoonCubit selectCartoonCubit;

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<SelectPoliticalCartoonState>(
        FakeSelectPoliticalCartoonState()
      );
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      scrollHeaderCubit = MockScrollHeaderCubit();
      selectCartoonCubit = MockSelectCartoonCubit();

      when(() => allCartoonsBloc.state)
        .thenReturn(const AllCartoonsState.initial());
      when(() => selectCartoonCubit.state)
        .thenReturn(const SelectPoliticalCartoonState());
    });

    tearDown(resetMocktailState);

    testWidgets('sets cartoon', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: List.filled(3, mockPoliticalCartoon
        ))
      );

      await tester.pumpApp(
        const StaggeredCartoonGrid(),
        allCartoonsBloc: allCartoonsBloc,
        selectCartoonCubit: selectCartoonCubit,
      );

      expect(find.byType(CartoonCard), findsNWidgets(3));

      await tester.tap(
        find.byType(CartoonCard).first,
      );

      verify(() => selectCartoonCubit.selectCartoon(mockPoliticalCartoon))
        .called(1);
    });

    testWidgets('display scroll header after scrolling', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: List.filled(10, mockPoliticalCartoon),
        )
      );

      await tester.pumpApp(
        const StaggeredCartoonGrid(),
        allCartoonsBloc: allCartoonsBloc,
        scrollHeaderCubit: scrollHeaderCubit,
      );

      await tester.drag(
        find.byType(StaggeredCartoonGrid), const Offset(0, -100)
      );

      await tester.drag(
        find.byType(StaggeredCartoonGrid), const Offset(0, 100)
      );

      verifyInOrder([
        scrollHeaderCubit.onScrollPastHeader,
        scrollHeaderCubit.onScrollBeforeHeader,
      ]);
    });

    testWidgets('loads more cartoons when near bottom', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: List.filled(16, mockPoliticalCartoon
        ))
      );

      await tester.pumpApp(
        const StaggeredCartoonGrid(),
        allCartoonsBloc: allCartoonsBloc,
        selectCartoonCubit: selectCartoonCubit,
        scrollHeaderCubit: scrollHeaderCubit,
      );

      await tester.drag(
        find.byType(StaggeredCartoonGrid), const Offset(0, -2000)
      );

      verify(() => allCartoonsBloc.add(const LoadMoreCartoons()));
    });

    testWidgets('staggered grid shows loading more indicator', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.loadingMore,
          cartoons: List.filled(2, mockPoliticalCartoon
        ))
      );

      await tester.pumpApp(
        const StaggeredCartoonGrid(),
        allCartoonsBloc: allCartoonsBloc,
      );

      expect(find.byKey(_staggeredGridLoadingMoreKey), findsOneWidget);
    });

    testWidgets('staggered grid refreshes successfully', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: List.filled(2, mockPoliticalCartoon)
        )
      );

      await tester.pumpApp(
        const StaggeredCartoonGrid(),
        allCartoonsBloc: allCartoonsBloc,
      );

      await tester.fling(
        find.byType(StaggeredCartoonGrid),
        const Offset(0, 2000),
        60
      );
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      verify(() => allCartoonsBloc.add(const RefreshCartoons())).called(1);
    });

    testWidgets('staggered grid triggers '
      'snackbar when refresh returns an error', (tester) async {
      whenListen(
        allCartoonsBloc,
        Stream.periodic(const Duration(seconds: 2),
          (i) => const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.refreshFailure,
        )).take(1),
        initialState: const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: List.filled(2, mockPoliticalCartoon),
        ),
      );

      await tester.pumpApp(
        const StaggeredCartoonGrid(),
        allCartoonsBloc: allCartoonsBloc,
      );

      await tester.pump(const Duration(seconds: 2));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Failed to refresh images'), findsOneWidget);
    });

    testWidgets('restarts complete '
      'when status is refresh success', (tester) async {
      whenListen(
        allCartoonsBloc,
        Stream.periodic(const Duration(seconds: 2),
          (i) => const AllCartoonsState.initial().copyWith(
            status: CartoonStatus.refreshSuccess
          )
        ).take(1),
        initialState: const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.refreshInitial,
          cartoons: List.filled(2, mockPoliticalCartoon)
        ),
      );

      await tester.pumpApp(
        const StaggeredCartoonGrid(),
        allCartoonsBloc: allCartoonsBloc,
      );

      expect(allCartoonsBloc.state.status, CartoonStatus.refreshInitial);
      await tester.pump(const Duration(seconds: 2));
      expect(allCartoonsBloc.state.status, CartoonStatus.refreshSuccess);
    });
  });
}
