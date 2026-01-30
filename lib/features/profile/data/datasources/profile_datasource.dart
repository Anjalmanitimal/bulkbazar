import 'dart:io';
import '../models/profile_api_model.dart';

abstract interface class IProfileRemoteDataSource {
  Future<String> uploadProfileImage(File image);
  Future<ProfileApiModel> getProfile();
}
