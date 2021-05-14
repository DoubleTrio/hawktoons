import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';

import '../../../mocks.dart';

void main() {
  group('SelectPoliticalCartoonState', () {
    var cartoon = MockPoliticalCartoon();
    test('supports value comparisons', () {
      expect(
        SelectPoliticalCartoonState(),
        SelectPoliticalCartoonState(),
      );
      expect(
        SelectPoliticalCartoonState(cartoon: cartoon),
        SelectPoliticalCartoonState(cartoon: cartoon),
      );
      expect(SelectPoliticalCartoonState().cartoonSelected, false);
      expect(
        SelectPoliticalCartoonState(
          cartoon: MockPoliticalCartoon()
        ).cartoonSelected, true
      );
    });
  });
}
