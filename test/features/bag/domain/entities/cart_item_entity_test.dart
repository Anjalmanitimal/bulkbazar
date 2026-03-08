import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/bag/domain/entities/cart_item_entity.dart';

void main() {
  /// HELPER — reusable base item
  CartItemEntity makeItem({int quantity = 2}) => CartItemEntity(
    productId: 'p1',
    name: 'Test Product',
    image: '/uploads/test.jpg',
    price: 100.0,
    moq: 1,
    quantity: quantity,
  );

  // ─────────────────────────────────────────
  // UNIT TEST 1 — CartItemEntity holds correct values
  // ─────────────────────────────────────────
  test('CartItemEntity should hold correct values', () {
    final item = makeItem();

    expect(item.productId, 'p1');
    expect(item.name, 'Test Product');
    expect(item.image, '/uploads/test.jpg');
    expect(item.price, 100.0);
    expect(item.moq, 1);
    expect(item.quantity, 2);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 2 — total getter calculates correctly
  // ─────────────────────────────────────────
  test('CartItemEntity.total should return price * quantity', () {
    final item = makeItem(quantity: 3);

    expect(item.total, 300.0);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 3 — copyWith updates quantity only
  // ─────────────────────────────────────────
  test(
    'CartItemEntity.copyWith should update quantity and keep other fields',
    () {
      final original = makeItem(quantity: 1);
      final updated = original.copyWith(quantity: 5);

      expect(updated.quantity, 5);
      expect(updated.productId, original.productId);
      expect(updated.name, original.name);
      expect(updated.price, original.price);
      expect(updated.image, original.image);
      expect(updated.moq, original.moq);
    },
  );

  // ─────────────────────────────────────────
  // UNIT TEST 4 — copyWith with no args keeps original
  // ─────────────────────────────────────────
  test('CartItemEntity.copyWith with no args should return same values', () {
    final item = makeItem(quantity: 4);
    final copy = item.copyWith();

    expect(copy.quantity, item.quantity);
    expect(copy.total, item.total);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 5 — total is zero when quantity is zero
  // ─────────────────────────────────────────
  test('CartItemEntity.total should be 0 when quantity is 0', () {
    final item = makeItem(quantity: 0);

    expect(item.total, 0.0);
  });
}
