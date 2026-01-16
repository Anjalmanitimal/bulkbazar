import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String email;
  final String fullName;
  final String role;
  final String? phoneNumber;

  const AuthEntity({
    this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [id, email, fullName, role, phoneNumber];
}
