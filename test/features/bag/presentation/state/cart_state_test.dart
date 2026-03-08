import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/bag/presentation/state/cart_state.dart';
import 'package:bulkbazar/features/bag/domain/entities/cart_item_entity.dart';

/// ─────────────────────────────────────────
/// HELPER
/// ─────────────────────────────────────────
CartItemEntity makeItem({
  String productId = 'p1',
  double price = 100.0,
  int quantity = 2,
  int moq = 1,
}) {
  return CartItemEntity(
    productId: productId,
    name: 'Test Product',
    image: '/uploads/test.jpg',
    price: price,
    moq: moq,
    quantity: quantity,
  );
}

void main() {
  // ─────────────────────────────────────────
  // UNIT TEST 1 — initial state is empty
  // ─────────────────────────────────────────
  test('CartState.initial should have empty items and zero total', () {
    final state = CartState.initial();

    expect(state.items, isEmpty);
    expect(state.totalAmount, 0.0);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 2 — totalAmount calculates correctly
  // ─────────────────────────────────────────
  test('CartState.totalAmount should sum price * quantity for all items', () {
    final state = CartState(
      items: [
        makeItem(productId: 'p1', price: 100.0, quantity: 2), // 200
        makeItem(productId: 'p2', price: 50.0, quantity: 3), // 150
      ],
    );

    expect(state.totalAmount, 350.0);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 3 — copyWith replaces items
  // ─────────────────────────────────────────
  test('CartState.copyWith should replace items correctly', () {
    final original = CartState(items: [makeItem(productId: 'p1')]);
    final updated = original.copyWith(items: [makeItem(productId: 'p2')]);

    expect(updated.items.length, 1);
    expect(updated.items.first.productId, 'p2');
  });

  // ─────────────────────────────────────────
  // UNIT TEST 4 — copyWith with no args keeps original
  // ─────────────────────────────────────────
  test('CartState.copyWith with no args should keep existing items', () {
    final original = CartState(items: [makeItem()]);
    final copy = original.copyWith();

    expect(copy.items.length, original.items.length);
    expect(copy.items.first.productId, original.items.first.productId);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 5 — totalAmount is zero for empty cart
  // ─────────────────────────────────────────
  test('CartState.totalAmount should be 0 when items list is empty', () {
    final state = CartState(items: []);

    expect(state.totalAmount, 0.0);
  });
}
