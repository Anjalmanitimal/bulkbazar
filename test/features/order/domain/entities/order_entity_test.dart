import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/order/domain/entities/order_entity.dart';

void main() {
  // ─────────────────────────────────────────
  // UNIT TEST 1 — OrderItemEntity holds correct values
  // covers line 21 (OrderItemEntity constructor)
  // ─────────────────────────────────────────
  test('OrderItemEntity should hold correct field values', () {
    final item = OrderItemEntity(
      productId: 'p1',
      productName: 'Rice Bag',
      quantity: 3,
      price: 200.0,
    );

    expect(item.productId, 'p1');
    expect(item.productName, 'Rice Bag');
    expect(item.quantity, 3);
    expect(item.price, 200.0);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 2 — OrderEntity holds correct values
  // covers line 7 (OrderEntity constructor)
  // ─────────────────────────────────────────
  test('OrderEntity should hold correct field values', () {
    final now = DateTime(2025, 1, 1);

    final order = OrderEntity(
      id: 'order1',
      items: [
        OrderItemEntity(
          productId: 'p1',
          productName: 'Sugar',
          quantity: 2,
          price: 100.0,
        ),
      ],
      totalAmount: 200.0,
      createdAt: now,
    );

    expect(order.id, 'order1');
    expect(order.items.length, 1);
    expect(order.totalAmount, 200.0);
    expect(order.createdAt, now);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 3 — OrderEntity supports multiple items
  // ─────────────────────────────────────────
  test('OrderEntity should support multiple order items', () {
    final order = OrderEntity(
      id: 'order2',
      items: [
        OrderItemEntity(
          productId: 'p1',
          productName: 'Rice',
          quantity: 1,
          price: 100.0,
        ),
        OrderItemEntity(
          productId: 'p2',
          productName: 'Oil',
          quantity: 2,
          price: 150.0,
        ),
      ],
      totalAmount: 400.0,
      createdAt: DateTime.now(),
    );

    expect(order.items.length, 2);
    expect(order.items.first.productName, 'Rice');
    expect(order.items.last.productName, 'Oil');
  });

  // ─────────────────────────────────────────
  // UNIT TEST 4 — OrderEntity can have empty items list
  // ─────────────────────────────────────────
  test('OrderEntity should allow empty items list', () {
    final order = OrderEntity(
      id: 'order3',
      items: [],
      totalAmount: 0.0,
      createdAt: DateTime.now(),
    );

    expect(order.items, isEmpty);
    expect(order.totalAmount, 0.0);
  });
}
