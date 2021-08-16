import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hawktoons/create_cartoon_sheet/bloc/bloc.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
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
    } else if (event is UpdatePage) {
      yield* _mapUpdatePageToState(event.page);
    }
  }

  Stream<CreateCartoonSheetState> _mapUploadImageToState() async* {
    try {
      final image = await imageRepository.getImage();
      if (image != null) {
        yield state.updateDetails(state.details.copyWith(
          filePath: image.path,
        ));
      }
    } catch (err) {
      print('picked file');
    }
  }

  Stream<CreateCartoonSheetState> _mapUpdatePageToState(CreateCartoonPage page)
  async* {
    yield state.updatePage(page);
  }
}
