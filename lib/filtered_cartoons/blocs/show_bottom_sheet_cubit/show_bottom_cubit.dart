import 'package:bloc/bloc.dart';

class ShowBottomSheetCubit extends Cubit<bool> {
  ShowBottomSheetCubit() : super(false);

  void openSheet() => emit(true);
  void closeSheet() => emit(false);
}
