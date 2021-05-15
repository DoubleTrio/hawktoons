import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class AllCartoonsEvent extends Equatable {
  const AllCartoonsEvent();
}

class LoadAllCartoons extends AllCartoonsEvent {
  LoadAllCartoons(this.sortByMode, this.imageType, this.tag );

  final SortByMode sortByMode;
  final ImageType imageType;
  final Tag tag;

  @override
  List<Object> get props => [sortByMode, imageType, tag];
}

class LoadMoreCartoons extends AllCartoonsEvent {
  LoadMoreCartoons(this.sortByMode, this.imageType, this.tag );

  final SortByMode sortByMode;
  final ImageType imageType;
  final Tag tag;

  @override
  List<Object> get props => [sortByMode, imageType, tag];
}

class ErrorAllCartoonsEvent extends AllCartoonsEvent {
  ErrorAllCartoonsEvent(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class UpdateAllCartoons extends AllCartoonsEvent {
  UpdateAllCartoons({required this.cartoons});
  final List<PoliticalCartoon> cartoons;

  @override
  List<Object> get props => [cartoons];
}
