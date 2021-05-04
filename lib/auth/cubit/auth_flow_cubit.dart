import 'package:bloc/bloc.dart';
import 'package:history_app/auth/models/auth_pages.dart';

class AuthFlowCubit extends Cubit<AuthPage> {
  AuthFlowCubit() : super(AuthPage.login);

  void setAuthPage(AuthPage page) => emit(page);
}
