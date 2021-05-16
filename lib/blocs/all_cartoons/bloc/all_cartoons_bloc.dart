import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class AllCartoonsBloc extends Bloc<AllCartoonsEvent, AllCartoonsState> {
  AllCartoonsBloc({required this.cartoonRepository})
      : super(AllCartoonsLoading());

  late StreamSubscription _cartoonsSubscription;
  final FirestorePoliticalCartoonRepository cartoonRepository;

  @override
  Stream<AllCartoonsState> mapEventToState(
      AllCartoonsEvent event,
      ) async* {
    if (event is LoadAllCartoons) {
      yield* _mapLoadAllCartoonsToState(event);
    } else if (event is UpdateAllCartoons) {
      yield* _mapUpdateAllCartoonsToState(event.cartoons);
    } else if (event is ErrorAllCartoonsEvent) {
      yield* _mapErrorAllCartoonsEventToState(event.errorMessage);
    }
  }

  Stream<AllCartoonsState> _mapLoadAllCartoonsToState
      (LoadAllCartoons event) async* {
    yield AllCartoonsLoading();
    _cartoonsSubscription = cartoonRepository
        .politicalCartoons(
        sortByMode: event.sortByMode,
        imageType: event.imageType,
        tag: event.tag
    ).listen((cartoons) {
      add(UpdateAllCartoons(cartoons: cartoons));
    }, onError: (err) {
      add(ErrorAllCartoonsEvent(err.toString()));
    });
  }

  Stream<AllCartoonsState> _mapUpdateAllCartoonsToState(
      List<PoliticalCartoon> cartoons) async* {
    yield AllCartoonsLoaded(cartoons: cartoons);
  }

  Stream<AllCartoonsState> _mapErrorAllCartoonsEventToState(
      String errorMessage) async* {
    yield AllCartoonsFailed(errorMessage);
  }

  @override
  Future<void> close() {
    _cartoonsSubscription.cancel();
    return super.close();
  }
}