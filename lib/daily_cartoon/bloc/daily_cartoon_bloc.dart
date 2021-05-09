import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:history_app/daily_cartoon/daily_cartoon.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class DailyCartoonBloc extends Bloc<DailyCartoonEvent, DailyCartoonState> {
  DailyCartoonBloc({required this.dailyCartoonRepository})
      : super(DailyCartoonInProgress());

  final PoliticalCartoonRepository dailyCartoonRepository;
  late StreamSubscription? _dailyCartoonSubscription;

  @override
  Stream<DailyCartoonState> mapEventToState(
    DailyCartoonEvent event,
  ) async* {
    if (event is LoadDailyCartoon) {
      yield* _mapLoadDailyCartoonToState();
    } else if (event is UpdateDailyCartoon) {
      yield* _mapUpdateDailyCartoonToState(event.cartoon);
    } else if (event is ErrorDailyCartoonEvent) {
      yield* _mapErrorDailyCartoonToState(event.errorMessage);
    }
  }

  Stream<DailyCartoonState> _mapLoadDailyCartoonToState() async* {
    _dailyCartoonSubscription =
        dailyCartoonRepository.getLatestPoliticalCartoon().listen((cartoon) {
      add(UpdateDailyCartoon(cartoon));
    }, onError: (err) {
      var code = err.code;
      if (code != 'permission-denied') {
        add(ErrorDailyCartoonEvent(err.code));
      }
    });
  }

  Stream<DailyCartoonState> _mapUpdateDailyCartoonToState(
      PoliticalCartoon cartoon) async* {
    yield DailyCartoonLoaded(cartoon);
  }

  Stream<DailyCartoonState> _mapErrorDailyCartoonToState(
      String errorMessage) async* {
    if (errorMessage !=
        '[cloud_firestore/permission-denied] The caller does not have permission to execute the specified operation.') {
      yield DailyCartoonFailed(errorMessage);
    }
  }

  @override
  Future<void> close() {
    _dailyCartoonSubscription?.cancel();
    return super.close();
  }
}
