import 'package:bloc/bloc.dart';
import 'package:hawktoons/all_cartoons/all_cartoons.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class AllCartoonsPageCubit extends Cubit<AllCartoonsPageState> {
  AllCartoonsPageCubit() : super(const AllCartoonsPageState.initial());

  void onScrollPastHeader() {
    return emit(state.copyWith(isScrolledPastHeader: true));
  }

  void onScrollBeforeHeader() {
    return emit(state.copyWith(isScrolledPastHeader: false));
  }

  void openFilterSheet() => emit(
    state.copyWith(shouldShowFilterSheet: true)
  );

  void closeFilterSheet() => emit(
    state.copyWith(shouldShowFilterSheet: false)
  );

  void openCreateCartoonSheet() => emit(
    state.copyWith(shouldShowCreateCartoonSheet: true)
  );

  void closeCreateCartoonSheet() => emit(
    state.copyWith(shouldShowCreateCartoonSheet: false)
  );

  void selectCartoon(PoliticalCartoon cartoon) => emit(
    state.copyWith(politicalCartoon: SelectPoliticalCartoonState(
      cartoon: cartoon
    ))
  );

  void deselectCartoon() => emit(
    state.copyWith(politicalCartoon: const SelectPoliticalCartoonState())
  );
}
