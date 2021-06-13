import 'package:equatable/equatable.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';

class AllCartoonsPageState extends Equatable {
  const AllCartoonsPageState({
    required this.isScrolledPastHeader,
    required this.shouldShowFilterSheet,
    required this.shouldShowCreateCartoonSheet,
    required this.politicalCartoon,
  });

  const AllCartoonsPageState.initial() : this(
    isScrolledPastHeader: false,
    shouldShowFilterSheet: false,
    shouldShowCreateCartoonSheet: false,
    politicalCartoon: const SelectPoliticalCartoonState(),
  );

  final bool isScrolledPastHeader;
  final bool shouldShowFilterSheet;
  final bool shouldShowCreateCartoonSheet;
  final SelectPoliticalCartoonState politicalCartoon;

  AllCartoonsPageState copyWith({
    bool? isScrolledPastHeader,
    bool? shouldShowFilterSheet,
    bool? shouldShowCreateCartoonSheet,
    SelectPoliticalCartoonState? politicalCartoon,
  }) {
    return AllCartoonsPageState(
      isScrolledPastHeader: isScrolledPastHeader ?? this.isScrolledPastHeader,
      shouldShowFilterSheet: shouldShowFilterSheet
        ?? this.shouldShowFilterSheet,
      shouldShowCreateCartoonSheet: shouldShowCreateCartoonSheet
        ?? this.shouldShowCreateCartoonSheet,
      politicalCartoon: politicalCartoon ?? this.politicalCartoon,
    );
  }

  @override
  List<Object?> get props => [
    isScrolledPastHeader,
    shouldShowFilterSheet,
    shouldShowCreateCartoonSheet,
    politicalCartoon,
  ];
}