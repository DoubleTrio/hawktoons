import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';


void main() {
  group('AllCartoonsState', () {
    test('supports value comparisons', () {
      expect(
        const AllCartoonsState.initial(),
        isNot(equals(const AllCartoonsState.initial()
          .copyWith(status: CartoonStatus.loading)
        ))
      );
      expect(
        const AllCartoonsState.initial()
          .copyWith(status: CartoonStatus.loading),
        equals(const AllCartoonsState.initial()
          .copyWith(status: CartoonStatus.loading
        ))
      );
    });
  });
}
