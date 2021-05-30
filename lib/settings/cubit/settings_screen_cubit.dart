import 'package:hawktoons/settings/models/settings_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SettingsScreenCubit extends Cubit<SettingsScreen> {
  SettingsScreenCubit() : super(SettingsScreen.main);

  void setScreen(SettingsScreen screen) {
    return emit(screen);
  }

  void deselectScreen() {
    return emit(SettingsScreen.main);
  }
}