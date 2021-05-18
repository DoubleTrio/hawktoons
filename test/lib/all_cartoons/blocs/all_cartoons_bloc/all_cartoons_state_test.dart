import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

void main() {
  group('AllCartoonsState', () {
    test('supports value comparisons', () {
      expect(
        const AllCartoonsState.initial(),
        isNot(equals(const AllCartoonsState.initial().copyWith(
          status: CartoonStatus.loading
        )))
      );
      expect(
        const AllCartoonsState.initial()
          .copyWith(status: CartoonStatus.loading),
        const AllCartoonsState.initial()
          .copyWith(status: CartoonStatus.loading),
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
          )))
        );
      });
    });
  });
}
