import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import '../repository/daily_cartoon_repository.dart';
import 'daily_cartoon.dart';

class DailyCartoonBloc extends Bloc<DailyCartoonEvent, DailyCartoonState> {
  DailyCartoonBloc({required this.dailyCartoonRepository})
      : super(DailyCartoonInProgress());

  final DailyCartoonRepository dailyCartoonRepository;

  @override
  Stream<DailyCartoonState> mapEventToState(
    DailyCartoonEvent event,
  ) async* {
    if (event is LoadDailyCartoon) {
      yield* _mapLoadDailyCartoonToState();
    }
  }

  Stream<DailyCartoonState> _mapLoadDailyCartoonToState() async* {
    try {
      var dailyCartoon = await dailyCartoonRepository.fetchDailyCartoon();
      yield DailyCartoonLoaded(dailyCartoon: dailyCartoon);
    } on Exception {
      yield DailyCartoonFailure();
    }
  }
}
