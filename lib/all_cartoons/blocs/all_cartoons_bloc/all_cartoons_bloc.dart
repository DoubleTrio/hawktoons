import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hawktoons/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';
import 'package:hawktoons/theme/theme.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';
import 'package:rxdart/rxdart.dart';

class AllCartoonsBloc extends Bloc<AllCartoonsEvent, AllCartoonsState> {
  AllCartoonsBloc({
    required this.cartoonRepository,
    required this.cartoonViewCubit,
  }) :
    super(AllCartoonsState.initial(view: cartoonViewCubit.state)) {
    _viewSubscription = cartoonViewCubit.stream.listen((view) {
      add(UpdateCartoonView(view));
    });
  }

  final int limit = 15;
  final FirestorePoliticalCartoonRepository cartoonRepository;
  final CartoonViewCubit cartoonViewCubit;
  late final StreamSubscription _viewSubscription;

  @override
  Stream<Transition<AllCartoonsEvent, AllCartoonsState>> transformEvents(
      Stream<AllCartoonsEvent> events,
      TransitionFunction<AllCartoonsEvent, AllCartoonsState> transitionFn) {
    final nonDebounceStream =
      events.where((event) =>
        event is LoadCartoons || event is UpdateCartoonView);
    final debounceStream = events
      .where((event) => event is LoadMoreCartoons || event is RefreshCartoons)
      .debounceTime(const Duration(milliseconds: 200));
    return super.transformEvents(
      MergeStream([nonDebounceStream, debounceStream]), transitionFn
    );
  }

  @override
  Stream<AllCartoonsState> mapEventToState(
    AllCartoonsEvent event,
  ) async* {
    if (event is LoadCartoons) {
      yield* _mapLoadCartoonsToState(event);
    } else if (event is LoadMoreCartoons) {
      yield* _mapLoadMoreCartoonsEventToState();
    } else if (event is RefreshCartoons) {
      yield* _mapRefreshCartoonsToState();
    } else if (event is UpdateCartoonView) {
      yield* _mapUpdateCartoonViewToState(event.view);
    }
  }

  Future<PoliticalCartoonList> _fetchCartoons(CartoonFilters filters) {
    final sortByMode = filters.sortByMode;
    final imageType = filters.imageType;
    final tag = filters.tag;
    return cartoonRepository.politicalCartoons(
      sortByMode: sortByMode,
      imageType: imageType,
      tag: tag,
      limit: limit,
    );
  }

  Stream<AllCartoonsState> _mapLoadCartoonsToState(
      LoadCartoons event) async* {
    if (event.filters == state.filters && state.hasLoadedInitial) return;
    yield state.copyWith(status: CartoonStatus.initial, filters: event.filters);
    try {
      final cartoons = await _fetchCartoons(event.filters);
      yield AllCartoonsState.loadSuccess(
        cartoons: cartoons,
        filters: event.filters,
        hasReachedMax: limit > cartoons.length,
        view: state.view,
      );
    } on Exception {
      yield state.copyWith(
        status: CartoonStatus.failure,
        filters: event.filters,
      );
    }
  }

  Stream<AllCartoonsState> _mapLoadMoreCartoonsEventToState() async* {
    if (state.hasReachedMax || state.status == CartoonStatus.loadingMore)
      return;
    try {
      yield state.copyWith(status: CartoonStatus.loadingMore);
      final moreCartoons = await cartoonRepository.loadMorePoliticalCartoons(
        sortByMode: state.filters.sortByMode,
        imageType: state.filters.imageType,
        tag: state.filters.tag,
        limit: limit,
      );
      yield state.copyWith(
        cartoons: List.of(state.cartoons)..addAll(moreCartoons),
        hasReachedMax: limit > moreCartoons.length,
        status: CartoonStatus.success,
      );
    } on Exception {
      yield state.copyWith(status: CartoonStatus.failure);
    }
  }

  Stream<AllCartoonsState> _mapRefreshCartoonsToState() async* {
    yield state.copyWith(
      status: CartoonStatus.refreshInitial,
      cartoons: state.cartoons
    );
    try {
      final cartoons = await _fetchCartoons(state.filters);
      yield state.copyWith(
        status: CartoonStatus.refreshSuccess,
        cartoons: cartoons,
        hasLoadedInitial: true,
        filters: state.filters,
        hasReachedMax: limit > cartoons.length,
      );
    } on Exception {
      yield state.copyWith(status: CartoonStatus.refreshFailure);
    }
  }

  Stream<AllCartoonsState> _mapUpdateCartoonViewToState(
      CartoonView view,
    ) async* {
    yield state.copyWith(
      view: view,
    );
  }

  @override
  Future<void> close() {
    _viewSubscription.cancel();
    return super.close();
  }
}
