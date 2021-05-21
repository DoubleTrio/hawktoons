import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class SelectPoliticalCartoonState extends Equatable {
  const SelectPoliticalCartoonState({this.cartoon});

  final PoliticalCartoon? cartoon;

  bool get cartoonSelected => cartoon != null;

  @override
  List<Object?> get props => [cartoon];
}

class SelectCartoonCubit extends Cubit<SelectPoliticalCartoonState> {
  SelectCartoonCubit() : super(const SelectPoliticalCartoonState());

  void selectCartoon(PoliticalCartoon cartoon) {
    return emit(SelectPoliticalCartoonState(cartoon: cartoon));
  }

  void deselectCartoon() {
    return emit(const SelectPoliticalCartoonState());
  }
}
