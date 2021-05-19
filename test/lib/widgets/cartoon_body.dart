import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/widgets/widgets.dart';

import '../helpers/helpers.dart';
import '../keys.dart';
import '../mocks.dart';

void main() {
  group('CartoonBody', () {
    testWidgets('renders author', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: CartoonBody(
            cartoon: mockPoliticalCartoon,
            addImagePadding: false,
          ),
        )
      );
      expect(find.byKey(cartoonSectionAuthorKey), findsOneWidget);
    });

    testWidgets('does not render author', (tester) async {
      await tester.pumpApp(
        SingleChildScrollView(
          child: CartoonBody(
            cartoon: mockPoliticalCartoon.copyWith(author: ''),
            addImagePadding: false,
          ),
        )
      );
      expect(find.byKey(cartoonSectionAuthorKey), findsNothing);
    });
  });
}
