import 'package:equatable/equatable.dart';

abstract class FilteredCartoonsState extends Equatable {
  const FilteredCartoonsState();
}

class FilteredCartoonLoading extends FilteredCartoonsState {
  FilteredCartoonLoading();

  @override
  List<Object?> get props => [];
}
