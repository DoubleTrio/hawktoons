import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:hawktoons/settings/settings.dart';

import '../../helpers/helpers.dart';


void main() {
  group('PrimaryColorItem', () {
    testWidgets('renders check icon', (tester) async {
      await tester.pumpApp(PrimaryColorItem(
        color: Colors.white,
        colorName: 'White', 
        selected: true, 
        onPrimaryChange: () {}
      ));
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('does not render check icon', (tester) async {
      await tester.pumpApp(PrimaryColorItem(
        color: Colors.white,
        colorName: 'White',
        selected: false,
        onPrimaryChange: () {}
      ));
      expect(find.byIcon(Icons.check), findsNothing);
    });
  });
}
