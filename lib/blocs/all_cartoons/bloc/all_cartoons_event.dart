import 'package:equatable/equatable.dart';
import 'package:history_app/blocs/all_cartoons/all_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

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