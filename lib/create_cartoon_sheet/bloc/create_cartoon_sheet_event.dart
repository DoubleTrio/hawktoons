import 'package:equatable/equatable.dart';

abstract class CreateCartoonSheetEvent extends Equatable {
  const CreateCartoonSheetEvent();
}

class UpdateFile extends CreateCartoonSheetEvent {
  const UpdateFile();

  @override
  List<Object?> get props => [];
}