import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../models/models.dart';

class CreateCartoonPageCubit extends Cubit<CreateCartoonPage> {
  CreateCartoonPageCubit() : super(CreateCartoonPage.image);

  void setPage(CreateCartoonPage page) {
    return emit(page);
  }
}
