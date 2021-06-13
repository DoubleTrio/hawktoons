import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';


void main() {
  final initialState = const CartoonFilters.initial();

  group('FilterSheetCubit', () {
    test('initial state is AllCartoonsPageCubit.initial', () {
      expect(
        FilterSheetCubit().state,
        initialState,
      );
    });

    blocTest<FilterSheetCubit, CartoonFilters>(
      'emits correct sort mode state'
      'when selectSortBy is invoked',
      build: () => FilterSheetCubit(),
      act: (cubit) => cubit..selectSortBy(SortByMode.earliestPublished),
      expect: () => [
        initialState.copyWith(sortByMode: SortByMode.earliestPublished),
      ],
    );

    blocTest<FilterSheetCubit, CartoonFilters>(
      'emits correct tag states'
      'when selectTag is invoked',
      build: () => FilterSheetCubit(),
      act: (cubit) => cubit..selectTag(Tag.tag5),
      expect: () => [
        initialState.copyWith(tag: Tag.tag5),
      ],
    );

    blocTest<FilterSheetCubit, CartoonFilters>(
      'emits correct image type states'
      'when selectImageType and deselectImageType is invoked',
      build: () => FilterSheetCubit(),
      act: (cubit) => cubit
        ..selectImageType(ImageType.document)
        ..deselectImageType(),
      expect: () => [
        initialState.copyWith(imageType: ImageType.document),
        initialState,
      ],
    );

    blocTest<FilterSheetCubit, CartoonFilters>(
      'emits initial state'
      'when reset is invoked',
      build: () => FilterSheetCubit(),
      act: (cubit) => cubit..reset(),
      expect: () => [
        initialState,
      ],
    );
  });
}