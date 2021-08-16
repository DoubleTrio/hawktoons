import 'package:equatable/equatable.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';

abstract class CreateCartoonSheetEvent extends Equatable {
  const CreateCartoonSheetEvent();
}

class UploadImage extends CreateCartoonSheetEvent {
  const UploadImage();

  @override
  List<Object?> get props => [];
}


class UpdatePage extends CreateCartoonSheetEvent {
  const UpdatePage(this.page);

  final CreateCartoonPage page;

  @override
  List<Object?> get props => [page];
}
