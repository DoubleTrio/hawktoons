import 'package:hawktoons/theme/theme.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CartoonViewCubit extends HydratedCubit<CartoonView> {
  CartoonViewCubit() : super(CartoonView.staggered);

  void setCartoonView(CartoonView view) {
    return emit(view);
  }

  @override
  CartoonView fromJson(Map<String, dynamic> json) {
    return CartoonView.values[json['cartoonView'] as int];
  }

  @override
  Map<String, dynamic> toJson(CartoonView state) {
    return <String, int>{'cartoonView': state.index};
  }
}
