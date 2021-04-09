import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class AllCartoonsState extends Equatable {
  const AllCartoonsState();
}

class AllCartoonsInProgress extends AllCartoonsState {
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

class AllCartoonsLoadFailure extends AllCartoonsState {
  AllCartoonsLoadFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'AllCartoonsLoadFailure($errorMessage)';
}
