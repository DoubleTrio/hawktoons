import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/all_cartoons/blocs/blocs.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../../mocks.dart';

void main() {
  PoliticalCartoon mockCartoon = MockPoliticalCartoon();
  group('SelectCartoonCubit', () {
    test('initial state is SelectPoliticalCartoonState()', () {
      expect(
        SelectCartoonCubit().state,
        equals(const SelectPoliticalCartoonState())
      );
    });

    blocTest<SelectCartoonCubit, SelectPoliticalCartoonState>(
      'emits [SelectPoliticalCartoonState(cartoon: $mockCartoon)] '
      'when selectCartoon is invoked',
      build: () => SelectCartoonCubit(),
      act: (cubit) => cubit.selectCartoon(mockCartoon),
      expect: () => [SelectPoliticalCartoonState(cartoon: mockCartoon)],
    );

    blocTest<SelectCartoonCubit, SelectPoliticalCartoonState>(
      'emits [SelectPoliticalCartoonState()] when closeSheet is invoked',
      build: () => SelectCartoonCubit(),
      seed: () => SelectPoliticalCartoonState(cartoon: mockCartoon),
      act: (cubit) => cubit.deselectCartoon(),
      expect: () => [const SelectPoliticalCartoonState()],
    );

    blocTest<SelectCartoonCubit, SelectPoliticalCartoonState>(
      'selecting and deselecting cartoon works',
      build: () => SelectCartoonCubit(),
      act: (cubit) => cubit
        ..selectCartoon(mockCartoon)
        ..deselectCartoon()
        ..selectCartoon(mockCartoon),
      expect: () => [
        SelectPoliticalCartoonState(cartoon: mockCartoon),
        const SelectPoliticalCartoonState(),
        SelectPoliticalCartoonState(cartoon: mockCartoon)
      ],
    );
  });
}
