import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:history_app/filtered_cartoons/blocs/blocs.dart';
import 'package:history_app/filtered_cartoons/blocs/sort_by_cubit/sort_by_cubit.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

import 'all_filters.dart';

class AllFiltersBloc extends Bloc<AllFiltersEvent, AllFiltersState> {
  AllFiltersBloc(
      {required UnitCubit unitCubit, required SortByCubit sortByCubit})
      : _unitCubit = unitCubit,
        _sortByCubit = sortByCubit,
        super(AllFiltersOptions(
            unit: unitCubit.state, sortByMode: sortByCubit.state)) {
    _unitCubitSubscription = _unitCubit.stream.listen((unit) {
      add(UpdateUnitFilter(unit));
    });
    _sortByCubitSubscription = _sortByCubit.stream.listen((mode) {
      add(UpdateSortByModeFilter(mode));
    });
  }

  final UnitCubit _unitCubit;
  final SortByCubit _sortByCubit;

  late StreamSubscription _unitCubitSubscription;
  late StreamSubscription _sortByCubitSubscription;

  @override
  Stream<AllFiltersState> mapEventToState(
    AllFiltersEvent event,
  ) async* {
    if (event is UpdateUnitFilter) {
      yield* _mapUpdateUnitFilterToState(event.unit);
    } else if (event is UpdateSortByModeFilter) {
      yield* _mapUpdateSortByFilterToState(event.sortByMode);
    }
  }

  Stream<AllFiltersState> _mapUpdateUnitFilterToState(
    Unit unit,
  ) async* {
    var currentState = state as AllFiltersOptions;
    yield currentState.copyWith(unit: unit);
  }

  Stream<AllFiltersState> _mapUpdateSortByFilterToState(
    SortByMode mode,
  ) async* {
    var currentState = state as AllFiltersOptions;
    yield currentState.copyWith(sortByMode: mode);
  }

  AllFiltersOptions copyWith({SortByMode? sortByMode, Unit? unit}) {
    var currentState = state as AllFiltersOptions;
    return AllFiltersOptions(
        sortByMode: sortByMode ?? currentState.sortByMode,
        unit: unit ?? currentState.unit);
  }

  @override
  Future<void> close() {
    _unitCubitSubscription.cancel();
    _sortByCubitSubscription.cancel();
    return super.close();
  }
}
