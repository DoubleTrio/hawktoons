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
      yield* _mapLoadAllCartoonsToState(event.sortByMode);
    } else if (event is LoadMoreCartoons) {
      yield* _mapLoadAllCartoonsToState(event.sortByMode);
    } else if (event is UpdateAllCartoons) {
      yield* _mapUpdateAllCartoonsToState(event.cartoons);
    } else if (event is ErrorAllCartoonsEvent) {
      yield* _mapErrorAllCartoonsEventToState(event.errorMessage);
    }
  }

  Stream<AllCartoonsState> _mapLoadAllCartoonsToState(
      SortByMode sortByMode) async* {
    _cartoonsSubscription = cartoonRepository
        .politicalCartoons(sortByMode: sortByMode)
        .listen((cartoons) {
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

  Stream<AllCartoonsState> _mapLoadMoreCartoonsToState(
      SortByMode sortByMode) async* {
    _cartoonsSubscription = cartoonRepository
        .loadMorePoliticalCartoons(sortByMode: sortByMode)
        .listen((cartoons) {
      if (state is AllCartoonsLoaded) {
        add(UpdateAllCartoons(
          cartoons: [...(state as AllCartoonsLoaded).cartoons, ...cartoons]
        ));
      }
    }, onError: (err) {
      add(ErrorAllCartoonsEvent(err.toString()));
    });
  }

  @override
  Future<void> close() {
    _cartoonsSubscription.cancel();
    return super.close();
  }
}
