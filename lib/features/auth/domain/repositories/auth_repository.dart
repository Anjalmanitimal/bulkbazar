import '../../data/models/auth_api_model.dart';
import '../../data/models/auth_hive_model.dart';

abstract interface class AuthRepository {
  Future<bool> registerLocal(AuthHiveModel model);
  Future<AuthHiveModel?> loginLocal(String email, String password);
  Future<AuthHiveModel?> getCurrentUser();
  Future<bool> logout();

  Future<AuthApiModel> registerRemote(AuthApiModel model);
  Future<AuthApiModel?> loginRemote(String email, String password);
}
