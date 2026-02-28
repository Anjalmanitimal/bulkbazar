class OrderEntity {
  final List<OrderItemEntity> items;
  final double totalAmount;

  OrderEntity({required this.items, required this.totalAmount});
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
