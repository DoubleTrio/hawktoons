import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class AllCartoonsEvent extends Equatable {
  const AllCartoonsEvent();
}

class LoadAllCartoons extends AllCartoonsEvent {
  LoadAllCartoons(this.sortByMode);

  final SortByMode sortByMode;

  @override
  List<Object> get props => [sortByMode];
}

class LoadMoreCartoons extends AllCartoonsEvent {
  LoadMoreCartoons(this.sortByMode);

  final SortByMode sortByMode;

  @override
  List<Object> get props => [sortByMode];
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
