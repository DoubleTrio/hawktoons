import 'package:bloc/bloc.dart';

class ShowCreateCartoonSheetCubit extends Cubit<bool> {
  ShowCreateCartoonSheetCubit() : super(false);

  void openSheet() => emit(true);

  void closeSheet() => emit(false);
}
