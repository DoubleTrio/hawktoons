import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:history_app/all_cartoons/bloc/all_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class AllCartoonsBloc extends Bloc<AllCartoonsEvent, AllCartoonsState> {
  AllCartoonsBloc({required this.cartoonRepository})
      : super(AllCartoonsLoading());

  final PoliticalCartoonRepository cartoonRepository;
  late StreamSubscription? _cartoonsSubscription;

  @override
  Stream<AllCartoonsState> mapEventToState(
    AllCartoonsEvent event,
  ) async* {
    if (event is LoadAllCartoons) {
      yield* _mapLoadAllCartoonsToState();
    } else if (event is UpdateAllCartoons) {
      yield* _mapUpdateAllCartoonsToState(event.cartoons);
    } else if (event is ErrorAllCartoonsEvent) {
      yield* _mapErrorAllCartoonsEventToState(event.errorMessage);
    }
  }

  Stream<AllCartoonsState> _mapLoadAllCartoonsToState() async* {
    _cartoonsSubscription =
        cartoonRepository.politicalCartoons().listen((cartoons) {
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
    _cartoonsSubscription?.cancel();
    return super.close();
  }
}
