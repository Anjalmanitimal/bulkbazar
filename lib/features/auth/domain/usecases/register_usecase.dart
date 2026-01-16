import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/models/auth_api_model.dart';
import '../repositories/auth_repository.dart';

final registerUsecaseProvider = Provider<RegisterUsecase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return RegisterUsecase(repository);
});

class RegisterUsecase {
  final IAuthRepository _repository;

  RegisterUsecase(this._repository);

  Future<bool> call(AuthApiModel model) async {
    final entity = model.toEntity();

    final result = await _repository.registerUser(entity);

    return result.fold((failure) => false, (success) => success);
  }
}
