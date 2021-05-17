import 'package:bloc/bloc.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class ImageTypeCubit extends Cubit<ImageType> {
  ImageTypeCubit() : super(ImageType.all);

  void selectImageType(ImageType type) {
    return emit(type);
  }

  void deselectImageType() {
    return emit(ImageType.all);
  }
}
