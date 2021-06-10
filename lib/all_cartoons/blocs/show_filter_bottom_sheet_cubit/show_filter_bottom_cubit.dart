import 'package:bloc/bloc.dart';

class ShowFilterBottomSheetCubit extends Cubit<bool> {
  ShowFilterBottomSheetCubit() : super(false);

  void openSheet() => emit(true);

  void closeSheet() => emit(false);
}
