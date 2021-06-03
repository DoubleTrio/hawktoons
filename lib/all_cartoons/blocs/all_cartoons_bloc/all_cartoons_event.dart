import 'package:equatable/equatable.dart';
import 'package:hawktoons/all_cartoons/blocs/all_cartoons_bloc/all_cartoons.dart';
import 'package:hawktoons/theme/models/cartoon_view.dart';

abstract class AllCartoonsEvent extends Equatable {
  const AllCartoonsEvent();
}

class LoadCartoons extends AllCartoonsEvent {
  const LoadCartoons(this.filters);

  final CartoonFilters filters;

  @override
  List<Object> get props => [filters];

  @override
  String toString() => 'LoadCartoons { filters: $filters }';
}

class LoadMoreCartoons extends AllCartoonsEvent {
  const LoadMoreCartoons();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoadMoreCartoons';
}

class RefreshCartoons extends AllCartoonsEvent {
  const RefreshCartoons();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'RefreshCartoons';
}

class UpdateCartoonView extends AllCartoonsEvent {
  const UpdateCartoonView(this.view);

  final CartoonView view;

  @override
  List<Object> get props => [view];

  @override
  String toString() => 'UpdateCartoonView';
}
