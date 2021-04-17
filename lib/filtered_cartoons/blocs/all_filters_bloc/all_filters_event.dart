import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class AllFiltersEvent extends Equatable {
  const AllFiltersEvent();
}

class UpdateSortByModeFilter extends AllFiltersEvent {
  UpdateSortByModeFilter(this.sortByMode);

  final SortByMode sortByMode;

  @override
  List<Object> get props => [sortByMode];
}

class UpdateUnitFilter extends AllFiltersEvent {
  UpdateUnitFilter(this.unit);

  final Unit unit;

  @override
  List<Object> get props => [unit];
}
