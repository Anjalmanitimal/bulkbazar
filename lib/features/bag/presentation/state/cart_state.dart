import '../../domain/entities/cart_item_entity.dart';

class CartState {
  final List<CartItemEntity> items;

  const CartState({required this.items});

  factory CartState.initial() {
    return const CartState(items: []);
  }

  CartState copyWith({List<CartItemEntity>? items}) {
    return CartState(items: items ?? this.items);
  }

  double get totalAmount {
    double total = 0;

    for (final item in items) {
      total += item.price * item.quantity;
    }

    return total;
  }
}
