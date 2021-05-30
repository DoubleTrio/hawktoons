import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class LatestCartoonEvent extends Equatable {
  const LatestCartoonEvent();
}

class LoadLatestCartoon extends LatestCartoonEvent {
  const LoadLatestCartoon();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoadLatestCartoon';
}

class UpdateLatestCartoon extends LatestCartoonEvent {
  const UpdateLatestCartoon(this.cartoon);

  final PoliticalCartoon cartoon;

  @override
  List<Object> get props => [cartoon];

  @override
  String toString() => 'UpdateLatestCartoon { cartoon: $cartoon }';
}

class ErrorLatestCartoonEvent extends LatestCartoonEvent {
  const ErrorLatestCartoonEvent(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'ErrorLatestCartoonEvent($errorMessage)';
}
