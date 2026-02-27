import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasource/auth_local_storage.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUsecase;
  final AuthLocalStorage localStorage;

  AuthCubit(this.loginUsecase, this.localStorage)
      : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());

    try {
      final token = await loginUsecase(username, password);
      await localStorage.saveToken(token);

      emit(AuthSuccess(token));
    } catch (e) {
      emit(AuthError("Invalid credentials"));
    }
  }

  Future<void> checkLogin() async {
    final token = await localStorage.getToken();
    if (token != null) {
      emit(AuthSuccess(token));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    await localStorage.clearToken();
    emit(AuthInitial());
  }
}
