import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hawktoons/create_cartoon_sheet/bloc/bloc.dart';
import 'package:image_repository/image_repository.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class CreateCartoonSheetBloc extends Bloc<
    CreateCartoonSheetEvent, CreateCartoonSheetState> {
  CreateCartoonSheetBloc({
    required this.imageRepository,
    required this.cartoonRepository
  }) : super(CreateCartoonSheetState.initial());

  final ImageRepository imageRepository;
  final PoliticalCartoonRepository cartoonRepository;

  @override
  Stream<CreateCartoonSheetState> mapEventToState(
      CreateCartoonSheetEvent event,
      ) async* {
    if (event is UploadImage) {
      yield* _mapUploadImageToState();
    }
  }

  Stream<CreateCartoonSheetState> _mapUploadImageToState() async* {
    try {
      final image = await imageRepository.getImage();
      if (image != null) {
        yield state.copyWith(details: state.details.copyWith(
          filePath: image.path,
        ));
      }
    } catch (err) {
      print('picked file');
    }
  }
}
