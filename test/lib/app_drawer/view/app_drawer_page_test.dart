import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/app_drawer/app_drawer.dart';
import '../../helpers/helpers.dart';

void main() {
  group('AppDrawerPage', () {
    group('AppDrawerPage', () {
      testWidgets('renders AppDrawer', (tester) async {
        await tester.pumpApp(
          const AppDrawerPage(),
        );
      });
    });
  });
}
