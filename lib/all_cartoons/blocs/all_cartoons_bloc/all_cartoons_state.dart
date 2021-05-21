import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

enum CartoonStatus { initial, success, loading, failure }

class CartoonFilters extends Equatable {
  const CartoonFilters({
    required this.sortByMode,
    required this.imageType,
    required this.tag
  });

  const CartoonFilters.initial({
    this.sortByMode = SortByMode.latestPosted,
    this.imageType = ImageType.all,
    this.tag = Tag.all,
  });

  final SortByMode sortByMode;
  final ImageType imageType;
  final Tag tag;

  CartoonFilters copyWith({
    SortByMode? sortByMode,
    ImageType? imageType,
    Tag? tag
  }) {
    return CartoonFilters(
      sortByMode: sortByMode ?? this.sortByMode,
      imageType: imageType ?? this.imageType,
      tag: tag ?? this.tag
    );
  }

  @override
  List<Object?> get props => [sortByMode, imageType, tag];
}

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
    required List<PoliticalCartoon> cartoons,
    required CartoonFilters filters,
    required bool hasReachedMax
  }) : this(
    cartoons: cartoons,
    filters: filters,
    status: CartoonStatus.success,
    hasReachedMax: hasReachedMax,
    hasLoadedInitial: true,
  );

  final List<PoliticalCartoon> cartoons;
  final CartoonFilters filters;
  final CartoonStatus status;
  final bool hasReachedMax;
  final bool hasLoadedInitial;

  @override
  List<Object>
    get props => [cartoons, filters, status, hasReachedMax, hasLoadedInitial];

  AllCartoonsState copyWith({
    List<PoliticalCartoon>? cartoons,
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
}
