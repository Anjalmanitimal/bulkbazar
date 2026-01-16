import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginUsecase(repository);
});

class LoginUsecase {
  final IAuthRepository _repository;

  LoginUsecase(this._repository);

  Future<AuthEntity?> call({
    required String email,
    required String password,
  }) async {
    final result = await _repository.loginUser(email, password);

    return result.fold((failure) => null, (authEntity) => authEntity);
  }
}
