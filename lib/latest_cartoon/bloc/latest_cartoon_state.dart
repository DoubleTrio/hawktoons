import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class LatestCartoonState extends Equatable {
  const LatestCartoonState();
}

class DailyCartoonInProgress extends LatestCartoonState {
  const DailyCartoonInProgress();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'DailyCartoonInProgress';
}

class DailyCartoonLoaded extends LatestCartoonState {
  const DailyCartoonLoaded(this.latestCartoon);

  final PoliticalCartoon latestCartoon;

  @override
  List<Object> get props => [latestCartoon];

  @override
  String toString() => 'DailyCartoonLoaded($latestCartoon)';
}

class DailyCartoonFailed extends LatestCartoonState {
  const DailyCartoonFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'DailyCartoonFailed($errorMessage)';
}
