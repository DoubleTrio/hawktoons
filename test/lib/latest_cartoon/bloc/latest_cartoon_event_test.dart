// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/latest_cartoon/bloc/latest_cartoon.dart';

import '../../mocks.dart';

void main() {
  group('LatestCartoonEvent', () {
    group('LoadLatestCartoon', () {
      test('supports value comparisons', () {
        expect(
          LoadLatestCartoon(),
          LoadLatestCartoon(),
        );
        expect(
          LoadLatestCartoon().toString(),
          LoadLatestCartoon().toString(),
        );
      });
    });
    group('ErrorLatestCartoonEvent', () {
      final errorMessage = 'Error message';
      test('supports value comparisons', () {
        expect(
          ErrorLatestCartoonEvent(errorMessage),
          ErrorLatestCartoonEvent(errorMessage),
        );
        expect(
          ErrorLatestCartoonEvent(errorMessage).toString(),
          ErrorLatestCartoonEvent(errorMessage).toString(),
        );
      });
    });

    group('UpdateLatestCartoon', () {
      test('supports value comparisons', () {
        final cartoon = MockPoliticalCartoon();
        expect(
          UpdateLatestCartoon(cartoon),
          UpdateLatestCartoon(cartoon),
        );
        expect(
          UpdateLatestCartoon(cartoon).toString(),
          UpdateLatestCartoon(cartoon).toString(),
        );
      });
    });
  });
}
