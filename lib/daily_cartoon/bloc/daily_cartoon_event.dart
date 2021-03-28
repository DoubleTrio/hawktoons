import 'package:equatable/equatable.dart';

abstract class DailyCartoonEvent extends Equatable {
  const DailyCartoonEvent();
}

class LoadDailyCartoon extends DailyCartoonEvent {
  @override
  List<Object> get props => [];
}
