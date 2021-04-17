import 'package:bloc/bloc.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class SortByCubit extends Cubit<SortByMode> {
  SortByCubit() : super(SortByMode.latestPosted);

  void selectSortBy(SortByMode sortBy) => emit(sortBy);
}
