// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';

import '../../../mocks.dart';

void main() {
  group('SelectPoliticalCartoonState', () {
    final cartoon = MockPoliticalCartoon();
    test('supports value comparisons', () {
      expect(
        SelectPoliticalCartoonState(),
        SelectPoliticalCartoonState(),
      );
      expect(
        SelectPoliticalCartoonState(cartoon: cartoon),
        SelectPoliticalCartoonState(cartoon: cartoon),
      );
      expect(
        SelectPoliticalCartoonState(cartoon: cartoon).toString(),
        SelectPoliticalCartoonState(cartoon: cartoon).toString(),
      );
      expect(SelectPoliticalCartoonState().cartoonSelected, false);
      expect(
        SelectPoliticalCartoonState(
          cartoon: MockPoliticalCartoon(),
        ).cartoonSelected,
        true
      );
    });
  });
}
