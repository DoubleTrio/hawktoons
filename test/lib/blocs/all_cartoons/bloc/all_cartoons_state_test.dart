import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/all_cartoons/bloc/all_cartoons_state.dart';

import '../../../mocks.dart';

void main() {
  group('AllCartoonsState', () {
    group('AllCartoonsLoading', () {
      test('supports value comparisons', () {
        expect(AllCartoonsLoading(), AllCartoonsLoading());
      });
    });
    group('MoreCartoonsLoading', () {
      test('supports value comparisons', () {
        expect(MoreCartoonsLoading(), MoreCartoonsLoading());
      });
    });
    group('AllCartoonsLoaded', () {
      final cartoons = [MockPoliticalCartoon(), MockPoliticalCartoon()];
      test('supports value comparisons', () {
        expect(
          AllCartoonsLoaded(cartoons: cartoons),
          AllCartoonsLoaded(cartoons: cartoons),
        );
      });
    });
    group('AllCartoonsFailed', () {
      test('supports value comparisons', () {
        expect(
          AllCartoonsFailed('Error message'),
          AllCartoonsFailed('Error message'),
        );
      });
    });
  });
}
