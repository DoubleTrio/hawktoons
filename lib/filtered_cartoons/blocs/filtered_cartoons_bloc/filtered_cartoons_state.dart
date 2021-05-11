import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class FilteredCartoonsState extends Equatable {
  const FilteredCartoonsState();
}

class FilteredCartoonsLoading extends FilteredCartoonsState {
  FilteredCartoonsLoading();

  @override
  List<Object?> get props => [];
}

class FilteredCartoonsLoaded extends FilteredCartoonsState {
  FilteredCartoonsLoaded(this.filteredCartoons, this.filter);

  final List<PoliticalCartoon> filteredCartoons;
  final Tag filter;

  @override
  List<Object?> get props => [filteredCartoons, filter];
}

class FilteredCartoonsFailed extends FilteredCartoonsState {
  FilteredCartoonsFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
