import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class SelectPoliticalCartoonState extends Equatable {
  const SelectPoliticalCartoonState({this.cartoon});

  final PoliticalCartoon? cartoon;

  bool get cartoonSelected => cartoon != null;

  @override
  List<Object?> get props => [cartoon];

  @override
  String toString() => 'SelectPoliticalCartoonState { cartoon: $cartoon }';
}