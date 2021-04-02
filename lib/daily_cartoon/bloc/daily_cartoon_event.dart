import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class DailyCartoonEvent extends Equatable {
  const DailyCartoonEvent();
}

class LoadDailyCartoon extends DailyCartoonEvent {
  @override
  List<Object> get props => [];
}

class UpdateDailyCartoon extends DailyCartoonEvent {
  UpdateDailyCartoon({required this.cartoon});

  final PoliticalCartoon cartoon;

  @override
  List<Object> get props => [cartoon];
}

class DailyCartoonErrored extends DailyCartoonEvent {
  DailyCartoonErrored({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
