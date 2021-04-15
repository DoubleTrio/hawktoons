import 'package:bloc/bloc.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class UnitCubit extends Cubit<Unit> {
  UnitCubit() : super(Unit.all);

  void selectUnit(Unit unit) {
    return emit(unit);
  }
}
