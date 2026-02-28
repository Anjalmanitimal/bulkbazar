import '../../domain/entities/cart_entity.dart';
import '../../../product/data/models/product_model.dart';

class CartModel extends CartEntity {
  CartModel({
    required super.id,
    required super.product,
    required super.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      product: ProductModel.fromJson(json['productId']),
      quantity: json['quantity'],
    );
  }
}
