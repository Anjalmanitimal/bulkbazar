import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../state/cart_state.dart';

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>((
  ref,
) {
  return CartViewModel();
});

class CartViewModel extends StateNotifier<CartState> {
  CartViewModel() : super(CartState.initial());

  /// ADD TO CART
  void addToCart(ProductEntity product) {
    final moq = product.pricing.first.moq;
    final price = product.pricing.first.price;

    final index = state.items.indexWhere((e) => e.productId == product.id);

    if (index >= 0) {
      final item = state.items[index];

      final updated = item.copyWith(quantity: item.quantity + moq);

      final newItems = [...state.items];
      newItems[index] = updated;

      state = CartState(items: newItems);
    } else {
      state = CartState(
        items: [
          ...state.items,
          CartItemEntity(
            productId: product.id,
            name: product.name,
            image: product.image,
            price: price,
            moq: moq,
            quantity: moq,
          ),
        ],
      );
    }
  }

  /// INCREASE
  void increase(String productId) {
    state = CartState(
      items: state.items.map((item) {
        if (item.productId == productId) {
          return item.copyWith(quantity: item.quantity + item.moq);
        }

        return item;
      }).toList(),
    );
  }

  /// DECREASE
  void decrease(String productId) {
    state = CartState(
      items: state.items.map((item) {
        if (item.productId == productId) {
          final newQty = item.quantity - item.moq;

          if (newQty < item.moq) return item;

          return item.copyWith(quantity: newQty);
        }

        return item;
      }).toList(),
    );
  }

  /// CLEAR AFTER ORDER
  void clearCart() {
    state = CartState.initial();
  }
}
