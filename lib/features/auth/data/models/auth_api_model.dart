class AuthApiModel {
  final String? id;
  final String email;
  final String fullName;
  final String role;
  final String? phoneNumber;

  AuthApiModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.phoneNumber,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      id: json['_id'],
      email: json['email'],
      fullName: json['fullName'],
      role: json['role'], // seller | customer
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "fullName": fullName,
      "role": role,
      "phoneNumber": phoneNumber,
    };
  }
}
