import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class DailyCartoonState extends Equatable {
  const DailyCartoonState();
}

class DailyCartoonInProgress extends DailyCartoonState {
  @override
  List<Object> get props => [];
}

class DailyCartoonLoad extends DailyCartoonState {
  DailyCartoonLoad({required this.dailyCartoon});

  final PoliticalCartoon dailyCartoon;

  @override
  List<Object> get props => [dailyCartoon];

  @override
  String toString() => 'DailyCartoonLoad { dailyCartoon: $dailyCartoon }';
}

class DailyCartoonFailure extends DailyCartoonState {
  DailyCartoonFailure({this.errorMessage = 'An error has occurred'});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'DailyCartoonFailure { errorMessage: $errorMessage }';
}
