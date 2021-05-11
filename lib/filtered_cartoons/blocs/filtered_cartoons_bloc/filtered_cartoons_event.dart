import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class FilteredCartoonsEvent extends Equatable {
  const FilteredCartoonsEvent();
}

class UpdateFilteredCartoons extends FilteredCartoonsEvent {
  UpdateFilteredCartoons(this.cartoons);

  final List<PoliticalCartoon> cartoons;

  @override
  List<Object?> get props => [cartoons];
}

class UpdateFilter extends FilteredCartoonsEvent {
  UpdateFilter(this.filter);

  final Tag filter;

  @override
  List<Object?> get props => [filter];
}
