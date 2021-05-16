import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:rxdart/rxdart.dart';

class AllCartoonsBloc extends Bloc<AllCartoonsEvent, AllCartoonsLoaded> {
  AllCartoonsBloc({required this.cartoonRepository})
      : super(const AllCartoonsLoaded.initial());

  final FirestorePoliticalCartoonRepository cartoonRepository;

  @override
  Stream<Transition<AllCartoonsEvent, AllCartoonsLoaded>> transformEvents(
    Stream<AllCartoonsEvent> events,
    TransitionFunction<AllCartoonsEvent, AllCartoonsLoaded> transitionFn
  ) {
    return events.debounceTime(
      const Duration(milliseconds: 100)).switchMap(transitionFn);
  }
  @override
  Stream<AllCartoonsLoaded> mapEventToState(
      AllCartoonsEvent event,
      ) async* {
    if (event is LoadAllCartoons) {
      yield* _mapLoadAllCartoonsToState(event);
      print('aaaa');
    } else if (event is LoadMoreCartoons) {
      yield* _mapLoadMoreCartoonsEventToState(event);
    }
  }

  Stream<AllCartoonsLoaded> _mapLoadAllCartoonsToState
      (LoadAllCartoons event) async* {
    yield state.copyWith(status: CartoonStatus.initial, filters: event.filters);
    print('here?');
    try {
      var cartoons = await cartoonRepository.politicalCartoons(
        sortByMode: event.filters.sortByMode,
        imageType: event.filters.imageType,
        tag: event.filters.tag
      );

      yield state.copyWith(
        cartoons: cartoons,
        status: CartoonStatus.success
      );
    } on Exception {
      yield state.copyWith(status: CartoonStatus.failure);
    }
  }


  Stream<AllCartoonsLoaded> _mapLoadMoreCartoonsEventToState(
      LoadMoreCartoons event) async* {
    try {
      if (!state.hasReachedMax || state.status != CartoonStatus.loading) {
        yield state.copyWith(status: CartoonStatus.loading);
        var cartoons = await cartoonRepository.loadMorePoliticalCartoons(
          sortByMode: event.filters.sortByMode,
          imageType: event.filters.imageType,
          tag: event.filters.tag
        );
        yield state.copyWith(
          cartoons: List.of(state.cartoons)..addAll(cartoons),
          hasReachedMax: cartoons.isEmpty ? true : false,
          status: CartoonStatus.success,
        );
      }
    } on Exception {
     yield state.copyWith(status: CartoonStatus.failure);
    }
  }
  @override
  Future<void> close() {
    return super.close();
  }
}