import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

enum CartoonStatus {
  initial,
  refreshInitial,
  success,
  refreshSuccess,
  loadingMore,
  failure,
  refreshFailure,
}

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

  @override
  String toString() =>
    'CartoonFilters { '
      'sortByMode: $sortByMode, '
      'imageType: $imageType, '
      'tag: $tag '
    '}';
}