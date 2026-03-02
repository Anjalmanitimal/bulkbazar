import '../../../../core/api/api_client.dart';
import '../../domain/entities/order_entity.dart';

class OrderRemoteDatasource {
  final ApiClient apiClient;

  OrderRemoteDatasource(this.apiClient);

  /// CREATE ORDER
  Future<void> createOrder({
    required List<Map<String, dynamic>> items,
    required double totalAmount,
  }) async {
    await apiClient.post(
      "/orders",
      data: {"items": items, "total": totalAmount},
    );
  }

  /// GET MY ORDERS
  Future<List<OrderEntity>> getMyOrders() async {
    final response = await apiClient.get("/orders/my-orders");

    final List data = response.data["data"] ?? [];

    return data.map<OrderEntity>((json) {
      return OrderEntity(
        id: json["_id"].toString(),
        totalAmount: (json["total"] as num).toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        items: (json["items"] as List).map<OrderItemEntity>((item) {
          final dynamic product = item["productId"];

          String productId = "";
          String productName = "";

          if (product is Map<String, dynamic>) {
            productId = product["_id"]?.toString() ?? "";
            productName =
                product["name"] ??
                product["productName"] ??
                product["title"] ??
                "Unknown Product";
          } else {
            productId = product.toString();
            productName =
                item["name"] ?? item["productName"] ?? "Unknown Product";
          }

          return OrderItemEntity(
            productId: productId,
            productName: productName,
            quantity: item["quantity"] ?? 0,
            price: (item["price"] as num).toDouble(),
          );
        }).toList(),
      );
    }).toList();
  }

  /// DELETE ORDER
  Future<void> deleteOrder(String orderId) async {
    await apiClient.delete("/orders/$orderId");
  }
}
