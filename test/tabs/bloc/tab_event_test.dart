import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/tab/tab.dart';

void main() {
  group('TabEvent', () {
    group('UpdateTab', () {
      test('supports value comparisons', () {
        expect(const UpdateTab(AppTab.all), const UpdateTab(AppTab.all));
      });
    });
  });
}
