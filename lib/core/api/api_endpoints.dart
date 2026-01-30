class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:4000/api';

  static const Duration connectionTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  static const String register = '/auth/register';
  static const String login = '/auth/login';

  static const String profile = "/profile";
  static const String profileUpload = "/profile/upload";
}
