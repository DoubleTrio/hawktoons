import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

abstract class AllFiltersState extends Equatable {
  const AllFiltersState();
}

class AllFiltersOptions extends AllFiltersState {
  AllFiltersOptions({required this.sortByMode, required this.unit});

  final SortByMode sortByMode;
  final Unit unit;

  @override
  List<Object> get props => [sortByMode, unit];

  AllFiltersOptions copyWith({Unit? unit, SortByMode? sortByMode}) {
    return AllFiltersOptions(
        sortByMode: sortByMode ?? this.sortByMode, unit: unit ?? this.unit);
  }
}
