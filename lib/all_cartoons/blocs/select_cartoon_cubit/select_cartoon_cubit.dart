import 'package:bloc/bloc.dart';
import 'package:history_app/all_cartoons/blocs/select_cartoon_cubit/models.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class SelectCartoonCubit extends Cubit<SelectPoliticalCartoonState> {
  SelectCartoonCubit() : super(const SelectPoliticalCartoonState());

  void selectCartoon(PoliticalCartoon cartoon) {
    return emit(SelectPoliticalCartoonState(cartoon: cartoon));
  }

  void deselectCartoon() {
    return emit(const SelectPoliticalCartoonState());
  }
}
