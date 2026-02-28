import '../entities/cart_entity.dart';

abstract class CartRepository {
  Future<List<CartEntity>> getCart();

  Future<void> updateQuantity(String cartId, int quantity);

  Future<void> checkout();
}
