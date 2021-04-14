import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import 'filtered_cartoons.dart';

class FilteredCartoonsBloc
    extends Bloc<FilteredCartoonsEvent, FilteredCartoonsState> {
  final AllCartoonsBloc _allCartoonsBloc;
  late StreamSubscription _allCartoonsSubscription;

  FilteredCartoonsBloc({required AllCartoonsBloc allCartoonsBloc})
      : _allCartoonsBloc = allCartoonsBloc,
        super(FilteredCartoonsBloc.initialState(allCartoonsBloc)) {
    _allCartoonsSubscription = allCartoonsBloc.stream.listen((state) {
      if (state is AllCartoonsLoaded) {
        add(UpdateFilteredCartoons(state.cartoons));
      }
    });
  }

  static FilteredCartoonsState initialState(AllCartoonsBloc allCartoonsBloc) {
    if (allCartoonsBloc.state is AllCartoonsLoading) {
      return FilteredCartoonsLoading();
    } else if (allCartoonsBloc.state is AllCartoonsLoaded) {
      return FilteredCartoonsLoaded(
          (allCartoonsBloc.state as AllCartoonsLoaded).cartoons, Unit.all);
    }

    return FilteredCartoonsFailed(
        (allCartoonsBloc.state as AllCartoonsFailed).errorMessage);
  }

  @override
  Stream<FilteredCartoonsState> mapEventToState(
      FilteredCartoonsEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateFilteredCartoons) {
      yield* _mapCartoonsUpdatedToState(event);
    }
  }

  Stream<FilteredCartoonsState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    final currentState = _allCartoonsBloc.state;
    if (currentState is AllCartoonsLoaded) {
      yield FilteredCartoonsLoaded(
          _mapCartoonsToFilteredCartoons(currentState.cartoons, event.filter),
          event.filter);
    }
  }

  Stream<FilteredCartoonsState> _mapCartoonsUpdatedToState(
    UpdateFilteredCartoons event,
  ) async* {
    final unitFilter = state is FilteredCartoonsLoaded
        ? (state as FilteredCartoonsLoaded).filter
        : Unit.all;
    yield FilteredCartoonsLoaded(
      _mapCartoonsToFilteredCartoons(
        (_allCartoonsBloc.state as AllCartoonsLoaded).cartoons,
        unitFilter,
      ),
      unitFilter,
    );
  }

  List<PoliticalCartoon> _mapCartoonsToFilteredCartoons(
      List<PoliticalCartoon> cartoons, Unit filter) {
    return cartoons.where((cartoon) {
      if (filter == Unit.all) {
        return true;
      } else {
        return cartoon.unit == filter;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _allCartoonsSubscription.cancel();
    return super.close();
  }
}
