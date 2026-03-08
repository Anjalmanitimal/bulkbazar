import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/auth_state.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../data/models/auth_api_model.dart';

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthState>(
  AuthViewModel.new,
);

class AuthViewModel extends Notifier<AuthState> {
  late LoginUsecase _loginUsecase;
  late RegisterUsecase _registerUsecase;

  @override
  AuthState build() {
    _loginUsecase = ref.read(loginUsecaseProvider);
    _registerUsecase = ref.read(registerUsecaseProvider);
    return const AuthState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);

    final user = await _loginUsecase(email: email, password: password);

    if (user == null) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: "Invalid credentials",
      );
    } else {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        authEntity: user,
      );
    }
  }

  Future<void> register(AuthApiModel user) async {
    state = state.copyWith(status: AuthStatus.loading);

    final success = await _registerUsecase(user);

    if (success) {
      state = state.copyWith(status: AuthStatus.registered);
    } else {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: "Registration failed",
      );
    }
  }
}
