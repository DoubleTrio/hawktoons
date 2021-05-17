import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/home/blocs/blocs.dart';

void main() {
  group('TabsBloc', () {
    test('initial state is AppTab.daily', () {
      var state = AppTab.daily;
      expect(TabBloc().state, equals(state));
    });

    blocTest<TabBloc, AppTab>(
      'emits [AppTab.all] '
      'when UpdateTab(AppTab.daily) is added',
      build: () => TabBloc(),
      act: (bloc) => bloc.add(UpdateTab(AppTab.all)),
      expect: () => [AppTab.all],
    );

    blocTest<TabBloc, AppTab>(
      'emits [AppTab.daily] '
      'when UpdateTab(AppTab.daily) is added and the current tab is AppTab.all',
      build: () => TabBloc(),
      seed: () => AppTab.all,
      act: (bloc) => bloc.add(UpdateTab(AppTab.daily)),
      expect: () => [AppTab.daily],
    );
  });
}
