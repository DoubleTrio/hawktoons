import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

void main() {
  group('TagCubit', () {
    test('initial state is Tag.all', () {
      expect(TagCubit().state, equals(Tag.all));
    });

    blocTest<TagCubit, Tag>(
      'emits [Tag.worldHistory] when selectTag is called',
      build: () => TagCubit(),
      act: (cubit) => cubit.selectTag(Tag.worldHistory),
      expect: () => [equals(Tag.worldHistory)],
    );

    blocTest<TagCubit, Tag>(
      'emits [Tag.tag5] when initialized with '
      'Tag.worldHistory and selectTag is called',
      build: () => TagCubit(),
      seed: () => Tag.worldHistory,
      act: (cubit) => cubit.selectTag(Tag.tag5),
      expect: () => [equals(Tag.tag5)],
    );
  });
}
