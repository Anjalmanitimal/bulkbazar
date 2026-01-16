import '../models/auth_api_model.dart';
import '../models/register_api_model.dart';

abstract interface class IAuthRemoteDatasource {
  Future<AuthApiModel> registerUser(RegisterApiModel user);
  Future<AuthApiModel?> loginUser(String email, String password);
  Future<AuthApiModel?> getUserById(String authId);
}
