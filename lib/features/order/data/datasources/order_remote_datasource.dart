import '../../../../core/api/api_client.dart';

class OrderRemoteDatasource {
  final ApiClient apiClient;

  OrderRemoteDatasource(this.apiClient);

  Future<void> createOrder({
    required List<Map<String, dynamic>> items,
    required double totalAmount,
  }) async {
    try {
      final response = await apiClient.post(
        "/orders",
        data: {"items": items, "total": totalAmount},
      );

      print("ORDER SUCCESS: ${response.data}");
    } catch (e) {
      print("ORDER ERROR: $e");
      rethrow;
    }
  }
}
