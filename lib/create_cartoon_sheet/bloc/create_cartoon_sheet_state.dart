import 'package:equatable/equatable.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';

enum CreateCartoonStatus {
  incomplete,
  loading,
  error,
  success,
}

class CreateCartoonSheetState extends Equatable {
  const CreateCartoonSheetState({
    required this.page,
    required this.details,
    required this.status,
  });

  CreateCartoonSheetState.initial() : this(
    page: CreateCartoonPage.uploadImage,
    details: const CreateCartoonDetails(),
    status: CreateCartoonStatus.incomplete,
  );

  final CreateCartoonPage page;
  final CreateCartoonDetails details;
  final CreateCartoonStatus status;

  CreateCartoonSheetState copyWith({
    CreateCartoonPage? page,
    CreateCartoonDetails? details,
    CreateCartoonStatus? status,
  }) {
    return CreateCartoonSheetState(
      page: page ?? this.page,
      details: details ?? this.details,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [page, details];
}