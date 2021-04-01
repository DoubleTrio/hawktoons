import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class DailyCartoonState extends Equatable {
  const DailyCartoonState();
}

class DailyCartoonInProgress extends DailyCartoonState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'DailyCartoonInProgress { }';
}

class DailyCartoonLoaded extends DailyCartoonState {
  DailyCartoonLoaded({required this.dailyCartoon});

  final PoliticalCartoon dailyCartoon;

  @override
  List<Object> get props => [dailyCartoon];

  @override
  String toString() => 'DailyCartoonLoaded { dailyCartoon: $dailyCartoon }';
}

class DailyCartoonFailure extends DailyCartoonState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'DailyCartoonFailure { }';
}
