import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/remote/auth_remote_datasource.dart';
import '../../data/models/auth_api_model.dart';
import '../../data/datasources/auth_datasource.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(
    authRemoteDatasource: ref.read(authRemoteDatasourceProvider),
  );
});

class LoginUseCase {
  final IAuthRemoteDatasource _authRemoteDatasource;

  LoginUseCase({required IAuthRemoteDatasource authRemoteDatasource})
    : _authRemoteDatasource = authRemoteDatasource;

  Future<AuthApiModel?> execute({
    required String email,
    required String password,
  }) {
    return _authRemoteDatasource.loginUser(email, password);
  }
}
