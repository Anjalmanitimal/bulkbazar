import 'package:bulkbazar/features/profile/domain/entities/profile_entity.dart';

class ProfileApiModel {
  final String? id;
  final String fullName;
  final String email;
  final String? profileImage;

  ProfileApiModel({
    this.id,
    required this.fullName,
    required this.email,
    this.profileImage,
  });

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) {
    return ProfileApiModel(
      id: json['_id']?.toString(),
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'fullName': fullName,
    'email': email,
    'profileImage': profileImage,
  };

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      fullName: fullName,
      email: email,
      profileImage: profileImage,
    );
  }

  factory ProfileApiModel.fromEntity(ProfileEntity entity) {
    return ProfileApiModel(
      id: entity.id,
      fullName: entity.fullName,
      email: entity.email,
      profileImage: entity.profileImage,
    );
  }
}
