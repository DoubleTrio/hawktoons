import 'package:equatable/equatable.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';

class CreateCartoonSheetState extends Equatable {
  const CreateCartoonSheetState({ required this.page, required this.details });

  CreateCartoonSheetState.initial() : this(
    page: CreateCartoonPage.uploadImage,
    details: const CreateCartoonDetails()
  );

  final CreateCartoonPage page;
  final CreateCartoonDetails details;

  CreateCartoonSheetState copyWith({
    CreateCartoonPage? page,
    CreateCartoonDetails? details,
  }) {
    return CreateCartoonSheetState(
      page: page ?? this.page,
      details: details ?? this.details
    );
  }

  @override
  List<Object?> get props => [page, details];
}