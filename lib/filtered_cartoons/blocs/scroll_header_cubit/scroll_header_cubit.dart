import 'package:bloc/bloc.dart';

class ScrollHeaderCubit extends Cubit<bool> {
  ScrollHeaderCubit() : super(false);

  void onScrollPastHeader() {
    return emit(true);
  }

  void onScrollBeforeHeader() {
    return emit(false);
  }
}
