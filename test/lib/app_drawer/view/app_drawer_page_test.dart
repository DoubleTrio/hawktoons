import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AppDrawerPage', () {
    group('semantics', () {
      testWidgets('passes guidelines for light theme', (tester) async {
        await tester.pumpApp(
          const AppDrawerPage(),
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });

      testWidgets('passes guidelines for dark theme', (tester) async {
        await tester.pumpApp(
          const AppDrawerPage(),
          mode: ThemeMode.dark,
        );
        expect(tester, meetsGuideline(textContrastGuideline));
        expect(tester, meetsGuideline(androidTapTargetGuideline));
      });
    });

    group('AppDrawerPage', () {
      testWidgets('renders AppDrawer', (tester) async {
        await tester.pumpApp(
          const AppDrawerPage(),
        );
      });
    });
  });
}
