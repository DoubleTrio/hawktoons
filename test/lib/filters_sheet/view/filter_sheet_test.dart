import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../fakes.dart';
import '../../helpers/helpers.dart';
import '../../keys.dart';
import '../../mocks.dart';

void main() {
  group('FilterSheet', () {
    final initialFilterSheetState = const CartoonFilters.initial();
    late AllCartoonsBloc allCartoonsBloc;
    late FilterSheetCubit filterSheetCubit;

    setUpAll(() {
      registerFallbackValue<AllCartoonsState>(FakeAllCartoonsState());
      registerFallbackValue<AllCartoonsEvent>(FakeAllCartoonsEvent());
      registerFallbackValue<CartoonFilters>(FakeCartoonFilters());
    });

    setUp(() {
      allCartoonsBloc = MockAllCartoonsBloc();
      filterSheetCubit = MockFiltersCubit();

      when(() => allCartoonsBloc.state)
        .thenReturn(
          const AllCartoonsState.initial(view: CartoonView.staggered
        )
      );
      when(() => filterSheetCubit.state).thenReturn(
        initialFilterSheetState
      );
    });

    // TODO - adjust ui to fix android text guidelines
    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          FilterSheet(),
          filterSheetCubit: filterSheetCubit
        );
        expect(tester, meetsGuideline(textContrastGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          FilterSheet(),
          mode: ThemeMode.dark,
          filterSheetCubit: filterSheetCubit
        );
        expect(tester, meetsGuideline(textContrastGuideline));
      });
    });

    testWidgets('selects sorting mode', (tester) async {
      await tester.pumpApp(
        FilterSheet(),
        filterSheetCubit: filterSheetCubit
      );
      await tester.dragUntilVisible(
        find.byKey(sortByTileKey),
        find.byType(FilterSheet),
        const Offset(0, -50)
      );
      await tester.tap(find.byKey(sortByTileKey));
      await tester.pumpAndSettle();
      verify(() => filterSheetCubit.selectSortBy(sortByMode)).called(1);
    });

    testWidgets('selects image type', (tester) async {
      await tester.pumpApp(
        FilterSheet(),
        filterSheetCubit: filterSheetCubit,
      );

      await tester.dragUntilVisible(
        find.byKey(imageTypeButtonKey),
        find.byType(FilterSheet),
        const Offset(0, -50),
      );

      await tester.tap(find.descendant(
        of: find.byKey(imageTypeButtonKey),
        matching: find.byType(Checkbox)),
      );

      await tester.pumpAndSettle();
      verify(() => filterSheetCubit.selectImageType(imageType)).called(1);
    });

    testWidgets('deselects image type', (tester) async {
      when(() => filterSheetCubit.state).thenReturn(
        initialFilterSheetState.copyWith(imageType: imageType)
      );
      await tester.pumpApp(
        FilterSheet(),
        filterSheetCubit: filterSheetCubit
      );

      await tester.dragUntilVisible(
        find.byKey(imageTypeButtonKey),
        find.byType(FilterSheet),
        const Offset(0, -50),
      );

      await tester.tap(
        find.descendant(
          of: find.byKey(imageTypeButtonKey),
          matching: find.byType(Checkbox),
        )
      );
      await tester.pumpAndSettle();
      verify(() => filterSheetCubit.deselectImageType()).called(1);
    });

    testWidgets('selects filter tag', (tester) async {
      await tester.pumpApp(
        FilterSheet(),
        filterSheetCubit: filterSheetCubit
      );
      await tester.dragUntilVisible(
        find.byKey(tagButtonKey),
        find.byType(FilterSheet),
        const Offset(0, -50),
      );
      await tester.tap(find.byKey(tagButtonKey));
      await tester.pumpAndSettle();
      verify(() => filterSheetCubit.selectTag(tag)).called(1);
    });

    testWidgets('deselects filter tag', (tester) async {
      when(() => filterSheetCubit.state).thenReturn(
        initialFilterSheetState.copyWith(tag: tag)
      );
      await tester.pumpApp(
        FilterSheet(),
        filterSheetCubit: filterSheetCubit
      );
      await tester.dragUntilVisible(
        find.byKey(tagButtonKey),
        find.byType(FilterSheet),
        const Offset(0, -50),
      );
      await tester.tap(find.byKey(tagButtonKey));
      await tester.pumpAndSettle();
      verify(() => filterSheetCubit.selectTag(Tag.all)).called(1);
    });

    testWidgets('reset button works', (tester) async {
      await tester.pumpApp(
        FilterSheet(),
        filterSheetCubit: filterSheetCubit
      );
      await tester.tap(find.byKey(resetFilterButtonKey));
      await tester.pumpAndSettle();
      verify(filterSheetCubit.reset).called(1);
    });

    testWidgets('applies correct filter', (tester) async {
      when(() => filterSheetCubit.state).thenReturn(
        CartoonFilters(
          sortByMode: sortByMode,
          imageType: imageType,
          tag: tag,
        )
      );

      await tester.pumpApp(
        FilterSheet(),
        allCartoonsBloc: allCartoonsBloc,
        filterSheetCubit: filterSheetCubit,
      );

      await tester.tap(find.byKey(applyFilterButtonKey));
      await tester.pumpAndSettle();

      final filters = CartoonFilters(
        sortByMode: sortByMode,
        imageType: imageType,
        tag: tag
      );

      verify(() => allCartoonsBloc.add(LoadCartoons(filters))).called(1);
    });
  });
}
