import '../../domain/entities/auth_entity.dart';

class AuthApiModel {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final String password;

  AuthApiModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      id: json['_id'],
      email: json['email'],
      fullName: json['fullName'],
      role: json['role'],
      password: json['password'],
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      email: email,
      fullName: fullName,
      role: role,
      password: password,
    );
  }
}
