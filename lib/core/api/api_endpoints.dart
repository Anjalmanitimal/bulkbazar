class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = "http://localhost:5050/api";

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const String register = "/auth/register";
  static const String login = "/auth/login";
}
