import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../mocks.dart';

const _staggeredGridLoadingMoreKey = Key('StaggeredCartoonGrid_LoadingMoreIndicator');

void main() {
  group('StaggeredCartoonGrid', () {
    late AllCartoonsBloc allCartoonsBloc;
    late SelectCartoonCubit selectCartoonCubit;
    late SortByCubit sortByCubit;
    late ImageTypeCubit imageTypeCubit;
    late TagCubit tagCubit;
    late ScrollHeaderCubit scrollHeaderCubit;

    Widget wrapper(Widget child) {
      return Scaffold(
        body: MultiBlocProvider(providers: [
          BlocProvider.value(value: allCartoonsBloc),
          BlocProvider.value(value: selectCartoonCubit),
          BlocProvider.value(value: sortByCubit),
          BlocProvider.value(value: imageTypeCubit),
          BlocProvider.value(value: tagCubit),
          BlocProvider.value(value: scrollHeaderCubit),
        ], child: child),
      );
    }

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<SelectPoliticalCartoonState>(
        FakeSelectPoliticalCartoonState()
      );
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);
      registerFallbackValue<ImageType>(ImageType.all);
      registerFallbackValue<Tag>(Tag.all);
    });

    setUp(() {
      selectCartoonCubit = MockSelectCartoonCubit();
      scrollHeaderCubit = MockScrollHeaderCubit();
      allCartoonsBloc = MockAllCartoonsBloc();
      tagCubit = MockTagCubit();
      sortByCubit = MockSortByCubit();
      imageTypeCubit = MockImageTypeCubit();

      when(() => selectCartoonCubit.state)
          .thenReturn(const SelectPoliticalCartoonState());
      when(() => allCartoonsBloc.state)
          .thenReturn(const AllCartoonsState.initial());
      when(() => tagCubit.state).thenReturn(Tag.all);
      when(() => sortByCubit.state).thenReturn(SortByMode.earliestPosted);
      when(() => imageTypeCubit.state).thenReturn(ImageType.all);
    });

    tearDown(resetMocktailState);

    testWidgets('sets cartoon', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: List.filled(3, mockPoliticalCartoon
        ))
      );
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid())),
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
          cartoons: List.filled(10, mockPoliticalCartoon
        ))
      );
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid())),
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
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid())),
      );

      await tester.drag(
        find.byType(StaggeredCartoonGrid), const Offset(0, -2000)
      );

      final filters = CartoonFilters(
        sortByMode: sortByCubit.state,
        imageType: imageTypeCubit.state,
        tag: tagCubit.state
      );

      verify(() => allCartoonsBloc.add(LoadMoreCartoons(filters)));
    });

    testWidgets('staggered grid shows loading more indicator', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.loadingMore,
          cartoons: List.filled(2, mockPoliticalCartoon
        ))
      );
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid())),
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
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid())),
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

    testWidgets('staggered grid triggers error snackbar when refresh returns an error', (tester) async {
      whenListen(
        allCartoonsBloc,
        Stream.value(const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.refreshFailure
        )),
        initialState: const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.success,
          cartoons: List.filled(2, mockPoliticalCartoon)
        ),
      );

      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid())),
      );

      await tester.pump(const Duration(seconds: 1));
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

      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid())),
      );

      expect(allCartoonsBloc.state.status, CartoonStatus.refreshInitial);
      await tester.pump(const Duration(seconds: 2));
      expect(allCartoonsBloc.state.status, CartoonStatus.refreshSuccess);
    });
  });
}
