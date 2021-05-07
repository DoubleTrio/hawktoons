import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class SelectPoliticalCartoonState extends Equatable {
  SelectPoliticalCartoonState({this.cartoon});

  final PoliticalCartoon? cartoon;

  @override
  List<Object?> get props => [cartoon];
}

class SelectCartoonCubit extends Cubit<SelectPoliticalCartoonState> {
  SelectCartoonCubit() : super(SelectPoliticalCartoonState());

  void selectCartoon(PoliticalCartoon cartoon) {
    return emit(SelectPoliticalCartoonState(cartoon: cartoon));
  }

  void deselectCartoon() {
    return emit(SelectPoliticalCartoonState());
  }
}
