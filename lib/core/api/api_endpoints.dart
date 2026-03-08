class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:4000/api';
  //static const String baseUrl = "http://192.168.1.11:4000/api";

  static const String imageBaseUrl = 'http://10.0.2.2:4000';
  //static const String imageBaseUrl = 'http://192.168.1.11:4000';

  static const Duration connectionTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Auth
  static const String register = '/auth/register';
  static const String login = '/auth/login';

  // Profile
  static const String profile = "/profile";
  static const String profileUpload = "/profile/upload";

  // Products ✅
  static const String products = "/products";
  static const String sellerProducts = "/products/seller";

  static const String createOrder = "$baseUrl/orders";
  static const String getMyOrders = "$baseUrl/orders/my-orders";
  static const String deleteOrder = "$baseUrl/orders";
}
