// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/app/app.dart';
import 'package:history_app/counter/counter.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'helpers/helpers.dart';

void main() {
  group('App - Screen #1', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpApp(const CounterPage());
      expect(find.byType(CounterView), findsOneWidget);
    });
  });

  group('App - Screen #2', () {
    testWidgets('renders DailyCartoonPage', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(find.byType(DailyCartoonPage), findsOneWidget);
    });
  });
}
