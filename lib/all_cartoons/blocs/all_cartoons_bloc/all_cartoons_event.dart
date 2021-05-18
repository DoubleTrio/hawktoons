import 'package:equatable/equatable.dart';
import 'package:history_app/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';

abstract class AllCartoonsEvent extends Equatable {
  const AllCartoonsEvent();
}

class LoadAllCartoons extends AllCartoonsEvent {
  LoadAllCartoons(this.filters);

  final CartoonFilters filters;

  @override
  List<Object> get props => [filters];
}

class LoadMoreCartoons extends AllCartoonsEvent {
  LoadMoreCartoons(this.filters);

  final CartoonFilters filters;

  @override
  List<Object> get props => [filters];
}
