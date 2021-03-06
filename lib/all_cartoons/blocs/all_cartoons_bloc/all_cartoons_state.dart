import 'package:equatable/equatable.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:hawktoons/appearances/models/cartoon_view.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class AllCartoonsState extends Equatable {
  const AllCartoonsState({
    required this.cartoons,
    required this.filters,
    required this.status,
    required this.hasReachedMax,
    required this.hasLoadedInitial,
    required this.view,
  });

  const AllCartoonsState.initial({ CartoonView view = CartoonView.staggered })
    : this(
      cartoons: const [],
      filters: const CartoonFilters.initial(),
      status: CartoonStatus.initial,
      hasReachedMax: false,
      hasLoadedInitial:false,
      view: view,
    );

  const AllCartoonsState.loadSuccess({
    required PoliticalCartoonList cartoons,
    required CartoonFilters filters,
    required bool hasReachedMax,
    required CartoonView view,
  }) : this(
    cartoons: cartoons,
    filters: filters,
    status: CartoonStatus.success,
    hasReachedMax: hasReachedMax,
    hasLoadedInitial: true,
    view: view,
  );

  final PoliticalCartoonList cartoons;
  final CartoonFilters filters;
  final CartoonStatus status;
  final bool hasReachedMax;
  final bool hasLoadedInitial;
  final CartoonView view;

  @override
  List<Object> get props => [
    cartoons,
    filters,
    status,
    hasReachedMax,
    hasLoadedInitial,
    view
  ];

  AllCartoonsState copyWith({
    PoliticalCartoonList? cartoons,
    CartoonFilters? filters,
    CartoonStatus? status,
    bool? hasReachedMax,
    bool? hasLoadedInitial,
    CartoonView? view,
  }) {
    return AllCartoonsState(
      cartoons: cartoons ?? this.cartoons,
      filters: filters ?? this.filters,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      hasLoadedInitial: hasLoadedInitial ?? this.hasLoadedInitial,
      view: view ?? this.view,
    );
  }

  @override
  String toString() =>
    'AllCartoonsState { '
      'cartoons: $cartoons, '
      'filters: $filters, '
      'status: $status, '
      'hasReachedMax: $hasReachedMax, '
      'hasLoadedInitial: $hasLoadedInitial, '
      'view: $view'
    '}';
}
