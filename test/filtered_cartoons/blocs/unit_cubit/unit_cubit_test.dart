import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

void main() {
  group('UnitCubit', () {
    test('initial state is Unit.all', () {
      expect(UnitCubit().state, equals(Unit.all));
    });

    blocTest<UnitCubit, Unit>(
      'emits [Unit.worldHistory] when selectUnit is called',
      build: () => UnitCubit(),
      act: (cubit) => cubit.selectUnit(Unit.worldHistory),
      expect: () => [equals(Unit.worldHistory)],
    );

    blocTest<UnitCubit, Unit>(
      'emits [Unit.unit5] when initialized with '
      'Unit.worldHistory and selectUnit is called',
      build: () => UnitCubit(),
      seed: () => Unit.worldHistory,
      act: (cubit) => cubit.selectUnit(Unit.unit5),
      expect: () => [equals(Unit.unit5)],
    );
  });
}
