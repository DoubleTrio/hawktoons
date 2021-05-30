import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hawktoons/latest_cartoon/latest_cartoon.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class LatestCartoonBloc extends Bloc<LatestCartoonEvent, LatestCartoonState> {
  LatestCartoonBloc({required this.cartoonRepository})
    : super(const DailyCartoonInProgress());

  final PoliticalCartoonRepository cartoonRepository;
  late StreamSubscription? _latestCartoonSubscription;

  @override
  Stream<LatestCartoonState> mapEventToState(
    LatestCartoonEvent event,
  ) async* {
    if (event is LoadLatestCartoon) {
      yield* _mapLoadLatestCartoonToState();
    } else if (event is UpdateLatestCartoon) {
      yield* _mapUpdateLatestCartoonToState(event.cartoon);
    } else if (event is ErrorLatestCartoonEvent) {
      yield* _mapErrorDailyCartoonToState(event.errorMessage);
    }
  }

  Stream<LatestCartoonState> _mapLoadLatestCartoonToState() async* {
    _latestCartoonSubscription =
        cartoonRepository.getLatestPoliticalCartoon().listen((cartoon) {
      add(UpdateLatestCartoon(cartoon));
    }, onError: (dynamic err) {
      if (err is FirebaseException) {
        final code = err.code;
        if (code == 'permission-denied') {
          return;
        }
        return add(ErrorLatestCartoonEvent(err.code));
      }
      return add(ErrorLatestCartoonEvent(err.toString()));
    });
  }

  Stream<LatestCartoonState> _mapUpdateLatestCartoonToState(
      PoliticalCartoon cartoon) async* {
    yield DailyCartoonLoaded(cartoon);
  }

  Stream<LatestCartoonState> _mapErrorDailyCartoonToState(
      String errorMessage) async* {
    yield DailyCartoonFailed(errorMessage);
  }

  @override
  Future<void> close() {
    _latestCartoonSubscription?.cancel();
    return super.close();
  }
}
