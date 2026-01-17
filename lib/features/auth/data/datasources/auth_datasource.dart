import '../../domain/entities/auth_entity.dart';
import '../models/auth_api_model.dart';

abstract interface class IAuthRemoteDatasource {
  Future<AuthApiModel> registerUser(AuthEntity entity);
  Future<AuthApiModel?> loginUser(String email, String password);
  Future<AuthApiModel?> getUserById(String authId);
}
