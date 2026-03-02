import '../../../../core/api/api_client.dart';
import '../../domain/entities/order_entity.dart';

class OrderRemoteDatasource {
  final ApiClient apiClient;

  OrderRemoteDatasource(this.apiClient);

  Future<void> createOrder({
    required List<Map<String, dynamic>> items,
    required double totalAmount,
  }) async {
    await apiClient.post(
      "/orders",
      data: {"items": items, "total": totalAmount},
    );
  }

  /// NEW — GET MY ORDERS
  Future<List<OrderEntity>> getMyOrders() async {
    final response = await apiClient.get("/orders/my-orders");

    final List data = response.data["data"];

    return data.map((e) {
      return OrderEntity(
        id: e["_id"],
        totalAmount: (e["total"] as num).toDouble(),
        createdAt: DateTime.parse(e["createdAt"]),
        items: (e["items"] as List)
            .map(
              (item) => OrderItemEntity(
                productId: item["productId"],
                quantity: item["quantity"],
                price: (item["price"] as num).toDouble(),
              ),
            )
            .toList(),
      );
    }).toList();
  }
}
