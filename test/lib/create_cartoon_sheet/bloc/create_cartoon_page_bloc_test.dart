import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_repository/image_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import '../../mocks.dart';

void main() {
  final fakePickedFile = PickedFile('123/FakeFile');
  late PoliticalCartoonRepository cartoonRepository;
  late ImageRepository imageRepository;

  setUp(() {
    cartoonRepository = MockCartoonRepository();
    imageRepository = MockImageRepository();
  });

  group('CreateCartoonSheetBloc', () {
    final initialState = CreateCartoonSheetState.initial();
    test('initial state is CartoonSheetState.initial', () {
      expect(
        CreateCartoonSheetBloc(
          cartoonRepository: cartoonRepository,
          imageRepository: imageRepository
        ).state,
        initialState,
      );
    });

    blocTest<CreateCartoonSheetBloc, CreateCartoonSheetState>(
      'emits cartoon details with files changed when UpdateFilter is added',
      build: () {
        when(imageRepository.getImage).thenAnswer((_) async => fakePickedFile);
        return CreateCartoonSheetBloc(
          cartoonRepository: cartoonRepository,
          imageRepository: imageRepository
        );
      },
      act: (bloc) => bloc.add(const UploadImage()),
      expect: () => <CreateCartoonSheetState>[
        CreateCartoonSheetState.initial().copyWith(
          details: const CreateCartoonDetails().copyWith(
            filePath: fakePickedFile.path,
          )
        ),
      ],
    );

    blocTest<CreateCartoonSheetBloc, CreateCartoonSheetState>(
      'emits [] when getImage throws an error',
      build: () {
        when(imageRepository.getImage).thenThrow(Exception('Error'));
        return CreateCartoonSheetBloc(
          cartoonRepository: cartoonRepository,
          imageRepository: imageRepository
        );
      },
      act: (bloc) => bloc.add(const UploadImage()),
      expect: () => <CreateCartoonSheetState>[
      ],
    );
  });
}
