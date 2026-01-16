class RegisterApiModel {
  final String email;
  final String password;
  final String fullName;
  final String role;

  RegisterApiModel({
    required this.email,
    required this.password,
    required this.fullName,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "fullName": fullName,
      "role": role,
    };
  }
}
