import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/remote/auth_remote_datasource.dart';
import '../../data/models/auth_api_model.dart';
import '../../data/datasources/auth_datasource.dart';

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(
    authRemoteDatasource: ref.read(authRemoteDatasourceProvider),
  );
});

class RegisterUseCase {
  final IAuthRemoteDatasource _authRemoteDatasource;

  RegisterUseCase({required IAuthRemoteDatasource authRemoteDatasource})
    : _authRemoteDatasource = authRemoteDatasource;

  Future<AuthApiModel> execute(AuthApiModel user) {
    return _authRemoteDatasource.registerUser(user);
  }
}
