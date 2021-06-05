import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/widgets/widgets.dart';

import '../../helpers/helpers.dart';
import '../../mocks.dart';


void main() {
  group('CartoonCardDetails', () {
    testWidgets('renders author', (tester) async {
      await tester.pumpApp(
        CartoonCardDetails(
          cartoon: mockPoliticalCartoon,
        )
      );
      expect(find.widgetWithText(TextSpan, 'Bob'), findsNothing);
    });

    testWidgets('does not render author', (tester) async {
      await tester.pumpApp(
        CartoonCardDetails(
          cartoon: mockPoliticalCartoon,
        )
      );

      expect(find.widgetWithText(TextSpan, 'Bob'), findsNothing);
    });
  });
}
