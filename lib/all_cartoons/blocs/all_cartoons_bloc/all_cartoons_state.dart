import 'package:equatable/equatable.dart';
import 'package:hawktoons/all_cartoons/blocs/all_cartoons_bloc/models.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class AllCartoonsState extends Equatable {
  const AllCartoonsState({
    required this.cartoons,
    required this.filters,
    required this.status,
    required this.hasReachedMax,
    required this.hasLoadedInitial,
  });

  const AllCartoonsState.initial({
    this.cartoons = const [],
    this.filters = const CartoonFilters.initial(),
    this.status = CartoonStatus.initial,
    this.hasReachedMax = false,
    this.hasLoadedInitial = false,
  });

  const AllCartoonsState.loadSuccess({
    required PoliticalCartoonList cartoons,
    required CartoonFilters filters,
    required bool hasReachedMax
  }) : this(
    cartoons: cartoons,
    filters: filters,
    status: CartoonStatus.success,
    hasReachedMax: hasReachedMax,
    hasLoadedInitial: true,
  );

  final PoliticalCartoonList cartoons;
  final CartoonFilters filters;
  final CartoonStatus status;
  final bool hasReachedMax;
  final bool hasLoadedInitial;

  @override
  List<Object>
    get props => [cartoons, filters, status, hasReachedMax, hasLoadedInitial];

  AllCartoonsState copyWith({
    PoliticalCartoonList? cartoons,
    CartoonFilters? filters,
    CartoonStatus? status,
    bool? hasReachedMax,
    bool? hasLoadedInitial,
  }) {
    return AllCartoonsState(
      cartoons: cartoons ?? this.cartoons,
      filters: filters ?? this.filters,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      hasLoadedInitial: hasLoadedInitial ?? this.hasLoadedInitial,
    );
  }

  @override
  String toString() =>
    'AllCartoonsState { '
      'cartoons: $cartoons, '
      'filters: $filters, '
      'status: $status, '
      'hasReachedMax: $hasReachedMax, '
      'hasLoadedInitial: $hasLoadedInitial '
    '}';
}
