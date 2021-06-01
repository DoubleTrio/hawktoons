import 'package:hawktoons/theme/theme.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PrimaryColorCubit extends HydratedCubit<PrimaryColor> {
  PrimaryColorCubit() : super(PrimaryColor.purple);

  void setColor(PrimaryColor color) {
    return emit(color);
  }

  @override
  PrimaryColor fromJson(Map<String, dynamic> json) {
    return PrimaryColor.values[json['primaryColor'] as int];
  }

  @override
  Map<String, dynamic> toJson(PrimaryColor state) {
    return <String, int>{'primaryColor': state.index};
  }
}