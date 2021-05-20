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

const _staggeredGridLoadingKey = Key('StaggeredCartoonGrid_LoadingIndicator');

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
        body: Column(
          children: [
            MultiBlocProvider(providers: [
              BlocProvider.value(value: allCartoonsBloc),
              BlocProvider.value(value: selectCartoonCubit),
              BlocProvider.value(value: sortByCubit),
              BlocProvider.value(value: imageTypeCubit),
              BlocProvider.value(value: tagCubit),
              BlocProvider.value(value: scrollHeaderCubit),
            ], child: child),
          ],
        ),
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
          .thenReturn(SelectPoliticalCartoonState());
      when(() => allCartoonsBloc.state)
          .thenReturn(const AllCartoonsState.initial());
      when(() => tagCubit.state).thenReturn(Tag.all);
      when(() => sortByCubit.state).thenReturn(SortByMode.earliestPosted);
      when(() => imageTypeCubit.state).thenReturn(ImageType.all);
    });

    testWidgets('sets cartoon', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid(
          cartoons: List.filled(3, mockPoliticalCartoon),
        ))),
      );
      expect(find.byType(CartoonCard), findsNWidgets(3));

      await tester.tap(
        find.byType(CartoonCard).first,
      );

      verify(() => selectCartoonCubit.selectCartoon(mockPoliticalCartoon))
        .called(1);
    });

    testWidgets('display scroll header after scrolling', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid(
          cartoons: List.filled(10, mockPoliticalCartoon)
        ))),
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
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid(
          cartoons: List.filled(16, mockPoliticalCartoon)
        ))),
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

    testWidgets('staggered grid shows loading indicator', (tester) async {
      when(() => allCartoonsBloc.state).thenReturn(
        const AllCartoonsState.initial().copyWith(status: CartoonStatus.loading)
      );
      await mockNetworkImagesFor(
        () => tester.pumpApp(wrapper(StaggeredCartoonGrid(
          cartoons: List.filled(2, mockPoliticalCartoon)
        ))),
      );
      expect(find.byKey(_staggeredGridLoadingKey), findsOneWidget);
    });
  });
}
