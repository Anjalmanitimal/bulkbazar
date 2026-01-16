import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bulkbazar/core/api/api_client.dart';
import 'package:bulkbazar/core/api/api_endpoints.dart';
import 'package:bulkbazar/core/services/hive/storage/user_session_service.dart';
import '../auth_datasource.dart';
import '../../models/auth_api_model.dart';
import '../../models/register_api_model.dart';
import '../../../domain/entities/auth_entity.dart';

final authRemoteDatasourceProvider = Provider<IAuthRemoteDatasource>((ref) {
  return AuthRemoteDatasource(
    apiClient: ref.read(apiClientProvider),
    userSessionService: ref.read(userSessionServiceProvider),
  );
});

class AuthRemoteDatasource implements IAuthRemoteDatasource {
  final ApiClient _apiClient;
  final UserSessionService _userSessionService;

  AuthRemoteDatasource({
    required ApiClient apiClient,
    required UserSessionService userSessionService,
  }) : _apiClient = apiClient,
       _userSessionService = userSessionService;

  @override
  Future<AuthApiModel> registerUser(AuthEntity entity) async {
    final response = await _apiClient.post(
      ApiEndpoints.register,
      data: {
        "email": entity.email,
        "password": entity.password, // REQUIRED
        "fullName": entity.fullName,
        "role": entity.role,
      },
    );

    return AuthApiModel.fromJson(response.data['user']);
  }

  @override
  Future<AuthApiModel?> loginUser(String email, String password) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );

    if (response.data['success'] == true) {
      final user = AuthApiModel.fromJson(response.data['data']);

      await _userSessionService.saveUserSession(
        userId: user.id!,
        email: user.email,
        fullName: user.fullName,
        role: user.role,
      );

      return user;
    }
    return null;
  }

  @override
  Future<AuthApiModel?> getUserById(String authId) {
    throw UnimplementedError();
  }
}
