import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:history_app/all_cartoons/bloc/all_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class AllCartoonsBloc extends Bloc<AllCartoonsEvent, AllCartoonsState> {
  AllCartoonsBloc({required this.cartoonRepository})
      : super(AllCartoonsInProgress());

  final PoliticalCartoonRepository cartoonRepository;
  late StreamSubscription? _cartoonsSubscription;

  @override
  Stream<AllCartoonsState> mapEventToState(
    AllCartoonsEvent event,
  ) async* {
    if (event is LoadAllCartoons) {
      yield* _mapLoadAllCartoonsToState();
    } else if (event is AllCartoonsUpdated) {
      yield* _mapUpdateAllCartoonsToState(event.cartoons);
    } else if (event is AllCartoonsErrored) {
      yield* _mapErrorAllCartoonsToState(event.errorMessage);
    }
  }

  Stream<AllCartoonsState> _mapLoadAllCartoonsToState() async* {
    _cartoonsSubscription =
        cartoonRepository.politicalCartoons().listen((cartoons) {
      add(AllCartoonsUpdated(cartoons: cartoons));
    }, onError: (err) {
      add(AllCartoonsErrored(errorMessage: err));
    });
  }

  Stream<AllCartoonsState> _mapUpdateAllCartoonsToState(
      List<PoliticalCartoon> cartoons) async* {
    yield AllCartoonsLoaded(cartoons: cartoons);
  }

  Stream<AllCartoonsState> _mapErrorAllCartoonsToState(
      String errorMessage) async* {
    yield AllCartoonsLoadFailure(errorMessage: errorMessage);
  }

  @override
  Future<void> close() {
    _cartoonsSubscription?.cancel();
    return super.close();
  }
}
