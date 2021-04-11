import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class DailyCartoonState extends Equatable {
  const DailyCartoonState();
}

class DailyCartoonInProgress extends DailyCartoonState {
  @override
  List<Object> get props => [];
}

class DailyCartoonLoaded extends DailyCartoonState {
  DailyCartoonLoaded({required this.dailyCartoon});

  final PoliticalCartoon dailyCartoon;

  @override
  List<Object> get props => [dailyCartoon];

  @override
  String toString() => 'DailyCartoonLoaded { dailyCartoon: $dailyCartoon }';
}

class DailyCartoonFailed extends DailyCartoonState {
  DailyCartoonFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'DailyCartoonFailed($errorMessage)';
}
