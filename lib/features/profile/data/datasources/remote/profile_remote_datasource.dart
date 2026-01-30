import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bulkbazar/core/api/api_client.dart';
import 'package:bulkbazar/core/api/api_endpoints.dart';
import 'package:bulkbazar/core/services/storage/token_service.dart';

import '../profile_datasource.dart';
import '../../models/profile_api_model.dart';

final profileRemoteDatasourceProvider = Provider<IProfileRemoteDataSource>((
  ref,
) {
  return ProfileRemoteDataSource(
    apiClient: ref.read(apiClientProvider),
    tokenService: ref.read(tokenServiceProvider),
  );
});

class ProfileRemoteDataSource implements IProfileRemoteDataSource {
  final ApiClient _apiClient;
  final TokenService _tokenService;

  ProfileRemoteDataSource({
    required ApiClient apiClient,
    required TokenService tokenService,
  }) : _apiClient = apiClient,
       _tokenService = tokenService;

  @override
  Future<String> uploadProfileImage(File image) async {
    final fileName = image.path.split('/').last;

    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path, filename: fileName),
    });

    final token = await _tokenService.getToken();

    final response = await _apiClient.post(
      ApiEndpoints.profileUpload,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    return response.data['profileImage'] as String;
  }

  @override
  Future<ProfileApiModel> getProfile() async {
    final token = await _tokenService.getToken();

    final response = await _apiClient.get(
      ApiEndpoints.profile,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return ProfileApiModel.fromJson(response.data);
  }
}
