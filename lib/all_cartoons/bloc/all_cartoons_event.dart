import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class AllCartoonsEvent extends Equatable {
  const AllCartoonsEvent();
}

class LoadAllCartoons extends AllCartoonsEvent {
  @override
  List<Object> get props => [];
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
