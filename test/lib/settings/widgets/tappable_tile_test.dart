import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/settings/settings.dart';

import '../../helpers/helpers.dart';

void main() {
  group('TappableTile', () {
    testWidgets('renders check icon when selected', (tester) async {
      await tester.pumpApp(
        TappableTile(
          onTap: () {},
          isLast: false,
          selected: true,
          child: const Text('Testing')
        ),
      );
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('does not render check icon when not selected', (tester) async {
      await tester.pumpApp(
        TappableTile(
          onTap: () {},
          isLast: false,
          selected: false,
          child: const Text('Testing'),
        ),
      );
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('renders arrow_forward_ios icon '
      'when navigable', (tester) async {
      await tester.pumpApp(
        TappableTile(
          onTap: () {},
          isLast: false,
          selected: false,
          navigable: true,
          child: const Text('Testing'),
        ),
      );
      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
    });

    testWidgets('does not render arrow_forward_ios icon '
      'when not navigable', (tester) async {
      await tester.pumpApp(
        TappableTile(
          onTap: () {},
          isLast: false,
          navigable: false,
          child: const Text('Testing'),
        ),
      );
      expect(find.byIcon(Icons.arrow_forward_ios), findsNothing);
    });

    testWidgets('renders bottom border when last tile', (tester) async {
      await tester.pumpApp(
        TappableTile(
          onTap: () {},
          isLast: true,
          child: const Text('Testing'),
        ),
      );
      final widget = tester.firstWidget(find.byType(Ink)) as Ink;

      expect(widget.decoration, const BoxDecoration(
        color: Color(0xfff5f5f5),
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(0xffe0e0e0),
          ),
          bottom: BorderSide(
            width: 1,
            color: Color(0xffe0e0e0),
          ),
        )
      ));
    });
  });
}
