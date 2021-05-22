import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';
import 'package:history_app/home/home.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('FilterPopUp', () {
    late AllCartoonsBloc allCartoonsBloc;
    late TagCubit tagCubit;
    late SortByCubit sortByCubit;
    late ImageTypeCubit imageTypeCubit;

    Widget wrapper(Widget child) {
      return Scaffold(
        body: MultiBlocProvider(providers: [
          BlocProvider.value(value: allCartoonsBloc),
          BlocProvider.value(value: tagCubit),
          BlocProvider.value(value: sortByCubit),
          BlocProvider.value(value: imageTypeCubit),
        ], child: child),
      );
    }

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<Tag>(Tag.all);
      registerFallbackValue<TabEvent>(FakeTabEvent());
      registerFallbackValue<SortByMode>(SortByMode.latestPosted);
      registerFallbackValue<ImageType>(ImageType.all);
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      tagCubit = MockTagCubit();
      sortByCubit = MockSortByCubit();
      imageTypeCubit = MockImageTypeCubit();

      when(() => allCartoonsBloc.state)
          .thenReturn(const AllCartoonsState.initial());
      when(() => tagCubit.state).thenReturn(Tag.all);
      when(() => sortByCubit.state).thenReturn(SortByMode.earliestPosted);
      when(() => imageTypeCubit.state).thenReturn(ImageType.all);
    });

    testWidgets('selects sorting mode', (tester) async {
      await tester.pumpApp(wrapper(FilterPopUp()));
      await tester.dragUntilVisible(
        find.byKey(sortByTileKey),
        find.byType(FilterPopUp),
        const Offset(0, -50)
      );
      await tester.tap(find.byKey(sortByTileKey));
      await tester.pumpAndSettle();
      verify(() => sortByCubit.selectSortBy(sortByMode)).called(1);
    });

    testWidgets('selects filter tag', (tester) async {
      when(() => tagCubit.state).thenReturn(Tag.all);
      await tester.pumpApp(wrapper(FilterPopUp()));
      await tester.tap(find.byKey(tagButtonKey));
      await tester.pumpAndSettle();
      verify(() => tagCubit.selectTag(tag)).called(1);
    });

    testWidgets('deselects filter tag', (tester) async {
      when(() => tagCubit.state).thenReturn(Tag.tag5);
      await tester.pumpApp(wrapper(FilterPopUp()));
      await tester.tap(find.byKey(tagButtonKey));
      await tester.pumpAndSettle();
      verify(() => tagCubit.selectTag(Tag.all)).called(1);
    });

    testWidgets('reset button works', (tester) async {
      when(() => tagCubit.state).thenReturn(Tag.tag5);
      when(() => sortByCubit.state).thenReturn(SortByMode.earliestPublished);
      await tester.pumpApp(wrapper(FilterPopUp()));
      await tester.tap(find.byKey(resetFilterButtonKey));
      await tester.pumpAndSettle();
      verify(() => tagCubit.selectTag(Tag.all)).called(1);
      verify(() => sortByCubit.selectSortBy(SortByMode.latestPosted)).called(1);
      verify(() => imageTypeCubit.deselectImageType()).called(1);
    });

    testWidgets('applies correct filter', (tester) async {
      when(() => tagCubit.state).thenReturn(tag);
      when(() => sortByCubit.state).thenReturn(sortByMode);
      when(() => imageTypeCubit.state).thenReturn(imageType);

      await tester.pumpApp(wrapper(FilterPopUp()));

      await tester.tap(find.byKey(applyFilterButtonKey));
      await tester.pumpAndSettle();

      final filters = CartoonFilters(
        sortByMode: sortByMode,
        imageType: imageType,
        tag: tag
      );

      verify(() => allCartoonsBloc.add(LoadCartoons(filters))).called(1);
    });

    testWidgets('selects image type', (tester) async {
      when(() => imageTypeCubit.state).thenReturn(ImageType.all);
      await tester.pumpApp(wrapper(
        FilterPopUp()
      ));

      await tester.tap(find.descendant(
        of: find.byKey(imageTypeButtonKey),
        matching: find.byType(Checkbox)),
      );

      await tester.pumpAndSettle();
      verify(() => imageTypeCubit.selectImageType(imageType)).called(1);
    });

    testWidgets('deselects image type', (tester) async {
      when(() => imageTypeCubit.state).thenReturn(imageType);
      await tester.pumpApp(wrapper(
        FilterPopUp()
      ));

      await tester.tap(
        find.descendant(
          of: find.byKey(imageTypeButtonKey),
          matching: find.byType(Checkbox)
        )
      );
      await tester.pumpAndSettle();
      verify(() => imageTypeCubit.deselectImageType()).called(1);
    });
  });
}
