import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:history_app/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:rxdart/rxdart.dart';

class AllCartoonsBloc extends Bloc<AllCartoonsEvent, AllCartoonsState> {
  AllCartoonsBloc({required this.cartoonRepository})
      : super(const AllCartoonsState.initial());

  final int limit = 15;
  final FirestorePoliticalCartoonRepository cartoonRepository;

  @override
  Stream<Transition<AllCartoonsEvent, AllCartoonsState>> transformEvents(
      Stream<AllCartoonsEvent> events,
      TransitionFunction<AllCartoonsEvent, AllCartoonsState> transitionFn) {
    final nonDebounceStream =
      events.where((event) => event is! LoadMoreCartoons);
    final debounceStream = events
      .where((event) => event is LoadMoreCartoons)
      .debounceTime(const Duration(milliseconds: 200));
    return super.transformEvents(
      MergeStream([nonDebounceStream, debounceStream]), transitionFn
    );
  }

  @override
  Stream<AllCartoonsState> mapEventToState(
    AllCartoonsEvent event,
  ) async* {
    if (event is LoadAllCartoons) {
      yield* _mapLoadAllCartoonsToState(event);
    } else if (event is LoadMoreCartoons) {
      yield* _mapLoadMoreCartoonsEventToState(event);
    }
  }

  Stream<AllCartoonsState> _mapLoadAllCartoonsToState(
      LoadAllCartoons event) async* {
    yield state.copyWith(status: CartoonStatus.initial, filters: event.filters);

    try {
      final cartoons = await cartoonRepository.politicalCartoons(
        sortByMode: event.filters.sortByMode,
        imageType: event.filters.imageType,
        tag: event.filters.tag,
        limit: limit,
      );
      yield state.copyWith(
        cartoons: cartoons,
        status: CartoonStatus.success,
        hasReachedMax: limit > cartoons.length
      );
    } on Exception {
      yield state.copyWith(status: CartoonStatus.failure);
    }
  }

  Stream<AllCartoonsState> _mapLoadMoreCartoonsEventToState(
      LoadMoreCartoons event) async* {
    try {
      if (!state.hasReachedMax && state.status != CartoonStatus.loading) {
        yield state.copyWith(status: CartoonStatus.loading);
        final moreCartoons = await cartoonRepository.loadMorePoliticalCartoons(
          sortByMode: event.filters.sortByMode,
          imageType: event.filters.imageType,
          tag: event.filters.tag,
          limit: limit,
        );
        yield state.copyWith(
          cartoons: List.of(state.cartoons)..addAll(moreCartoons),
          hasReachedMax: limit > moreCartoons.length,
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
