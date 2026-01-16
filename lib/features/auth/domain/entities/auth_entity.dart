import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String email;
  final String fullName;
  final String role;
  final String password; // required for register

  const AuthEntity({
    this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.password,
  });

  @override
  List<Object?> get props => [id, email, fullName, role];
}
