class OrderEntity {
  final String id;
  final List<OrderItemEntity> items;
  final double totalAmount;
  final DateTime createdAt;

  OrderEntity({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.createdAt,
  });
}

class OrderItemEntity {
  final String productId;
  final int quantity;
  final double price;

  OrderItemEntity({
    required this.productId,
    required this.quantity,
    required this.price,
  });
}
