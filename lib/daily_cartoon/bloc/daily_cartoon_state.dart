import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class DailyCartoonState extends Equatable {
  const DailyCartoonState();
}

class DailyCartoonInProgress extends DailyCartoonState {
  const DailyCartoonInProgress();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'DailyCartoonInProgress';
}

class DailyCartoonLoaded extends DailyCartoonState {
  const DailyCartoonLoaded(this.dailyCartoon);

  final PoliticalCartoon dailyCartoon;

  @override
  List<Object> get props => [dailyCartoon];

  @override
  String toString() => 'DailyCartoonLoaded($dailyCartoon)';
}

class DailyCartoonFailed extends DailyCartoonState {
  const DailyCartoonFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'DailyCartoonFailed($errorMessage)';
}
