import 'package:bulkbazar/features/product/domain/entities/product_entity.dart';

class CartEntity {
  final String id;
  final ProductEntity product;
  final int quantity;

  CartEntity({required this.id, required this.product, required this.quantity});

  double get totalPrice => product.pricing.first.price * quantity;

  int get moq => product.pricing.first.moq;
}
