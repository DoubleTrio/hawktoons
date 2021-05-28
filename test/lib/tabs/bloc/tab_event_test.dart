import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/tab/tab.dart';

void main() {
  group('TabEvent', () {
    group('UpdateTab', () {
      test('supports value comparisons', () {
        expect(UpdateTab(AppTab.all), UpdateTab(AppTab.all));
        expect(
          UpdateTab(AppTab.daily).toString(),
          UpdateTab(AppTab.daily).toString(),
        );
      });
    });
  });
}
