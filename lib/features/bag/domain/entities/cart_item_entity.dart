class CartItemEntity {
  final String productId;
  final String name;
  final String image;
  final double price;
  final int moq;
  final int quantity;

  CartItemEntity({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.moq,
    required this.quantity,
  });

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(
      productId: productId,
      name: name,
      image: image,
      price: price,
      moq: moq,
      quantity: quantity ?? this.quantity,
    );
  }

  double get total => price * quantity;
}
