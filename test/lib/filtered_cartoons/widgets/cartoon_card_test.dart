import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/all_cartoons.dart';

import '../../helpers/helpers.dart';
import '../../mocks.dart';

final _cartoonCardAuthorKey =
  Key('CartoonCard_Author_${mockPoliticalCartoon.id}');

void main() {
  group('CartoonCard', () {
    testWidgets('renders author', (tester) async {
      await tester.pumpApp(
        CartoonCard(cartoon: mockPoliticalCartoon, onTap: () {}
      ));
      expect(find.byKey(_cartoonCardAuthorKey), findsOneWidget);
    });

    testWidgets('does not render author', (tester) async {
      await tester.pumpApp(
        CartoonCard(
          cartoon: mockPoliticalCartoon.copyWith(author: ''),
          onTap: () {}
        )
      );
      expect(find.byKey(_cartoonCardAuthorKey), findsNothing);
    });
  });
}
