import 'package:equatable/equatable.dart';

abstract class CreateCartoonSheetEvent extends Equatable {
  const CreateCartoonSheetEvent();
}

class UploadImage extends CreateCartoonSheetEvent {
  const UploadImage();

  @override
  List<Object?> get props => [];
}