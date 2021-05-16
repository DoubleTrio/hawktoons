import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/all_cartoons/bloc/all_cartoons_state.dart';


void main() {
  group('AllCartoonsLoaded', () {
    test('supports value comparisons', () {
      expect(
        const AllCartoonsLoaded.initial(),
        isNot(equals(const AllCartoonsLoaded.initial()
          .copyWith(status: CartoonStatus.loading)
        ))
      );
      expect(
        const AllCartoonsLoaded.initial()
          .copyWith(status: CartoonStatus.loading),
        equals(const AllCartoonsLoaded.initial()
          .copyWith(status: CartoonStatus.loading
        ))
      );
    });
  });
}
