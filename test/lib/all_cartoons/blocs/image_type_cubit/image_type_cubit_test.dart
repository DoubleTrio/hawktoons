import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/all_cartoons/blocs/blocs.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

void main() {
  group('ImageTypeCubit', () {
    test('initial state is ImageType.all', () {
      expect(ImageTypeCubit().state, equals(ImageType.all));
    });

    blocTest<ImageTypeCubit, ImageType>(
      'emits [ImageType.cartoon] when selectImageType is called',
      build: () => ImageTypeCubit(),
      act: (cubit) => cubit.selectImageType(ImageType.cartoon),
      expect: () => [ImageType.cartoon],
    );

    blocTest<ImageTypeCubit, ImageType>(
      'emits [ImageType.photo, ImageType.cartoon] when '
      'electImageType is called twice',
      build: () => ImageTypeCubit(),
      act: (cubit) => cubit
        ..selectImageType(ImageType.photo)
        ..selectImageType(ImageType.cartoon),
      expect: () => [ImageType.photo, ImageType.cartoon],
    );

    blocTest<ImageTypeCubit, ImageType>(
      'emits [ImageType.photo, ImageType.cartoon] when '
      'electImageType is called twice',
      build: () => ImageTypeCubit(),
      seed: () => ImageType.cartoon,
      act: (cubit) => cubit.deselectImageType(),
      expect: () => [ImageType.all],
    );
  });
}
