import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final remote = ref.read(cartRemoteDatasourceProvider);

  return CartRepositoryImpl(remote);
});

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasource remote;

  CartRepositoryImpl(this.remote);

  @override
  Future<List<CartEntity>> getCart() {
    return remote.getCart();
  }

  @override
  Future<void> updateQuantity(String cartId, int quantity) {
    return remote.updateQuantity(cartId, quantity);
  }

  @override
  Future<void> checkout() {
    return remote.checkout();
  }
}
