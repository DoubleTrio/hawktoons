import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/tab/tab.dart';

void main() {
  group('TabsBloc', () {
    test('initial state is AppTab.latest', () {
      expect(TabBloc().state, equals(AppTab.latest));
    });

    blocTest<TabBloc, AppTab>(
      'emits [AppTab.all] '
      'when UpdateTab(AppTab.latest) is added',
      build: () => TabBloc(),
      act: (bloc) => bloc.add(UpdateTab(AppTab.all)),
      expect: () => [AppTab.all],
    );

    blocTest<TabBloc, AppTab>(
      'emits [AppTab.latest] '
      'when UpdateTab(AppTab.latest) is added '
      'and the current tab is AppTab.all',
      build: () => TabBloc(),
      seed: () => AppTab.all,
      act: (bloc) => bloc.add(UpdateTab(AppTab.latest)),
      expect: () => [AppTab.latest],
    );
  });
}
