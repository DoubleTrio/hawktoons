import 'package:bloc/bloc.dart';
import 'package:hawktoons/filters_sheet/filters_sheet.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class FilterSheetCubit extends Cubit<CartoonFilters> {
  FilterSheetCubit() : super(const CartoonFilters.initial());

  void selectImageType(ImageType imageType) {
    return emit(state.copyWith(imageType: imageType));
  }

  void deselectImageType() {
    return emit(state.copyWith(imageType: ImageType.all));
  }

  void selectSortBy(SortByMode sortByMode) {
    return emit(state.copyWith(sortByMode: sortByMode));
  }

  void selectTag(Tag tag) {
    return emit(state.copyWith(tag: tag));
  }

  void reset() {
    return emit(const CartoonFilters.initial());
  }
}
