import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';
import 'package:hawktoons/appearances/appearances.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

void main() {
  group('AllCartoonsState', () {
    test('supports value comparisons', () {
      expect(
        const AllCartoonsState.initial(view: CartoonView.card),
        isNot(equals(const AllCartoonsState.initial(view: CartoonView.card)
          .copyWith(
            status: CartoonStatus.loadingMore
          )
        ))
      );
    });
    group('CartoonFilters', () {
      test('copyWith works', () {
        expect(
          const CartoonFilters.initial(),
          isNot(equals(const CartoonFilters.initial().copyWith(
            sortByMode: SortByMode.latestPosted,
            imageType: ImageType.infographic,
            tag: Tag.tag5,
          ).copyWith(
            sortByMode: SortByMode.latestPublished
          )))
        );
      });
    });
  });
}
