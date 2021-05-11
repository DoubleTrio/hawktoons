import 'package:bloc/bloc.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class TagCubit extends Cubit<Tag> {
  TagCubit() : super(Tag.all);

  void selectTag(Tag tag) {
    return emit(tag);
  }
}
