import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/l10n/l10n.dart';
import 'package:hawktoons/utils/time_ago.dart';
import 'package:intl/intl.dart';

import '../helpers/helpers.dart';

void main() {
  group('TimeAgo', () {
    late List<DateTime> durations;
    late Timestamp timestamp;
    late DateTime dateTime;

    setUpAll(() {
      timestamp = Timestamp.now();
      dateTime = timestamp.toDate();
      durations = [
        const Duration(seconds: 1),
        const Duration(seconds: 9),
        const Duration(minutes: 1),
        const Duration(minutes: 9),
        const Duration(hours: 1),
        const Duration(hours: 9),
        const Duration(days: 1, minutes: 2),
        const Duration(days: 6, hours: 23),
        const Duration(days: 5),
        const Duration(days: 8),
        const Duration(days: 20),
      ].map(dateTime.add).toList();
    });

    testWidgets('TimeAgo (numeric) works', (tester) async {
      await tester.pumpApp(Builder(builder: (BuildContext context) {
        final l10n = context.l10n;
        final timeAgo = TimeAgo(l10n: l10n, locale: 'en');
        return Column(
          children: [
            ...durations.map((date) =>
              Text(timeAgo.timeAgoSinceDate(timestamp, date: date))
            )
          ],
        );
      }));
      expect(
        find.text(DateFormat('dd MMM yyyy', 'en').format(dateTime)),
        findsOneWidget,
      );
      expect(find.text('1 week ago'), findsOneWidget);
      expect(find.text('1 day ago'), findsOneWidget);
      expect(find.text('5 days ago'), findsOneWidget);
      expect(find.text('1 hour ago'), findsOneWidget);
      expect(find.text('9 hours ago'), findsOneWidget);
      expect(find.text('1 minute ago'), findsOneWidget);
      expect(find.text('9 minutes ago'), findsOneWidget);
      expect(find.text('9 seconds ago'), findsOneWidget);
      expect(find.text('Just now'), findsOneWidget);
    });

    testWidgets('TimeAgo (non-numeric) works', (tester) async {
      await tester.pumpApp(Builder(builder: (BuildContext context) {
        final l10n = context.l10n;
        final timeAgo = TimeAgo(l10n: l10n, locale: 'en');
        return Column(
          children: [
            ...durations.map((date) => Text(
              timeAgo.timeAgoSinceDate(
                timestamp,
                date: date,
                numericDates: false
              )
            ))
          ],
        );
      }));

      expect(
        find.text(DateFormat('dd MMM yyyy', 'en').format(dateTime)),
        findsOneWidget
      );
      expect(find.text('Last week'), findsOneWidget);
      expect(find.text('Yesterday'), findsOneWidget);
      expect(find.text('5 days ago'), findsOneWidget);
      expect(find.text('An hour ago'), findsOneWidget);
      expect(find.text('9 hours ago'), findsOneWidget);
      expect(find.text('A minute ago'), findsOneWidget);
      expect(find.text('9 minutes ago'), findsOneWidget);
      expect(find.text('9 seconds ago'), findsOneWidget);
      expect(find.text('Just now'), findsOneWidget);
    });

    testWidgets('TimeAgo (non-numeric) works for regular date', (tester) async {
      await tester.pumpApp(Builder(builder: (BuildContext context) {
        final l10n = context.l10n;
        final timeAgo = TimeAgo(l10n: l10n, locale: 'en');
        return Column(
          children: [
            Text(timeAgo.timeAgoSinceDate(timestamp)),
          ],
        );
      }));
      expect(find.text('Just now'), findsOneWidget);
    });
  });
}
