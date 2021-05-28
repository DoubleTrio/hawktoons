import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppDrawerCubit extends Cubit<bool> {
  AppDrawerCubit() : super(false);

  void openDrawer() {
    return emit(true);
  }

  void closeDrawer() {
    return emit(false);
  }
}
