import 'dart:io';
import '../models/profile_api_model.dart';

abstract interface class IProfileRemoteDataSource {
  Future<ProfileApiModel> getProfile();
  Future<String> uploadProfileImage(File image);
}
