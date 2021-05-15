import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class AllCartoonsState extends Equatable {
  const AllCartoonsState();
}

class AllCartoonsLoading extends AllCartoonsState {
  @override
  List<Object> get props => [];
}

class MoreCartoonsLoading extends AllCartoonsState {
  @override
  List<Object> get props => [];
}

class AllCartoonsLoaded extends AllCartoonsState {
  AllCartoonsLoaded({required this.cartoons});

  final List<PoliticalCartoon> cartoons;

  @override
  List<Object> get props => [cartoons];

  @override
  String toString() => 'AllCartoonsLoaded { cartoons: $cartoons }';
}

class AllCartoonsFailed extends AllCartoonsState {
  AllCartoonsFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'AllCartoonsFailed($errorMessage)';
}
