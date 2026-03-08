import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bulkbazar/features/bag/presentation/view_model/cart_view_model.dart';
import 'package:bulkbazar/features/bag/domain/entities/cart_item_entity.dart';
import 'package:bulkbazar/features/bag/presentation/state/cart_state.dart';
import 'package:bulkbazar/features/product/domain/entities/product_entity.dart';

/// ─────────────────────────────────────────
/// HELPERS
/// ─────────────────────────────────────────

/// Creates a fake ProductEntity with minimal required fields
ProductEntity makeProduct({
  String id = 'p1',
  String name = 'Test Product',
  double price = 100.0,
  int moq = 1,
}) {
  return ProductEntity(
    id: id,
    name: name,
    image: '/uploads/test.jpg',
    description: 'A test product',
    pricing: [PricingEntity(price: price, moq: moq)],
    category: 'Test',
  );
}

/// Returns a fresh ProviderContainer with CartViewModel
ProviderContainer makeContainer() {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  return container;
}

void main() {
  // ─────────────────────────────────────────
  // UNIT TEST 1 — initial state is empty
  // ─────────────────────────────────────────
  test('CartViewModel initial state should be empty', () {
    final container = makeContainer();
    final state = container.read(cartViewModelProvider);

    expect(state.items, isEmpty);
    expect(state.totalAmount, 0.0);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 2 — addToCart adds a new item
  // ─────────────────────────────────────────
  test('addToCart should add a new item to cart', () {
    final container = makeContainer();
    final notifier = container.read(cartViewModelProvider.notifier);

    notifier.addToCart(makeProduct());

    final state = container.read(cartViewModelProvider);
    expect(state.items.length, 1);
    expect(state.items.first.productId, 'p1');
    expect(state.items.first.quantity, 1);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 3 — addToCart same product increases qty by moq
  // ─────────────────────────────────────────
  test('addToCart same product twice should increase quantity by moq', () {
    final container = makeContainer();
    final notifier = container.read(cartViewModelProvider.notifier);
    final product = makeProduct(moq: 2);

    notifier.addToCart(product);
    notifier.addToCart(product);

    final state = container.read(cartViewModelProvider);
    expect(state.items.length, 1);
    expect(state.items.first.quantity, 4); // moq=2, added twice → 2+2=4
  });

  // ─────────────────────────────────────────
  // UNIT TEST 4 — increase adds moq to quantity
  // ─────────────────────────────────────────
  test('increase should add moq to item quantity', () {
    final container = makeContainer();
    final notifier = container.read(cartViewModelProvider.notifier);

    notifier.addToCart(makeProduct(moq: 1));
    notifier.increase('p1');

    final state = container.read(cartViewModelProvider);
    expect(state.items.first.quantity, 2);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 5 — decrease subtracts moq from quantity
  // ─────────────────────────────────────────
  test('decrease should subtract moq from item quantity', () {
    final container = makeContainer();
    final notifier = container.read(cartViewModelProvider.notifier);

    notifier.addToCart(makeProduct(moq: 1));
    notifier.increase('p1'); // qty = 2
    notifier.decrease('p1'); // qty = 1

    final state = container.read(cartViewModelProvider);
    expect(state.items.first.quantity, 1);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 6 — decrease below moq does nothing
  // ─────────────────────────────────────────
  test('decrease below moq should not reduce quantity further', () {
    final container = makeContainer();
    final notifier = container.read(cartViewModelProvider.notifier);

    notifier.addToCart(makeProduct(moq: 1)); // qty = 1
    notifier.decrease('p1'); // qty < moq → no change

    final state = container.read(cartViewModelProvider);
    expect(state.items.first.quantity, 1);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 7 — remove deletes item from cart
  // ─────────────────────────────────────────
  test('remove should delete item from cart', () {
    final container = makeContainer();
    final notifier = container.read(cartViewModelProvider.notifier);

    notifier.addToCart(makeProduct(id: 'p1'));
    notifier.addToCart(makeProduct(id: 'p2', name: 'Second'));
    notifier.remove('p1');

    final state = container.read(cartViewModelProvider);
    expect(state.items.length, 1);
    expect(state.items.first.productId, 'p2');
  });

  // ─────────────────────────────────────────
  // UNIT TEST 8 — clearCart resets to empty state
  // ─────────────────────────────────────────
  test('clearCart should reset cart to empty state', () {
    final container = makeContainer();
    final notifier = container.read(cartViewModelProvider.notifier);

    notifier.addToCart(makeProduct());
    notifier.addToCart(makeProduct(id: 'p2', name: 'Second'));
    notifier.clearCart();

    final state = container.read(cartViewModelProvider);
    expect(state.items, isEmpty);
    expect(state.totalAmount, 0.0);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 9 — totalAmount calculates correctly
  // ─────────────────────────────────────────
  test('totalAmount should sum all item totals correctly', () {
    final container = makeContainer();
    final notifier = container.read(cartViewModelProvider.notifier);

    notifier.addToCart(makeProduct(id: 'p1', price: 100.0, moq: 2)); // 200
    notifier.addToCart(makeProduct(id: 'p2', price: 50.0, moq: 1)); // 50

    final state = container.read(cartViewModelProvider);
    expect(state.totalAmount, 250.0);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 10 — multiple products stay separate
  // ─────────────────────────────────────────
  test('adding different products should keep them as separate items', () {
    final container = makeContainer();
    final notifier = container.read(cartViewModelProvider.notifier);

    notifier.addToCart(makeProduct(id: 'p1', name: 'Product A'));
    notifier.addToCart(makeProduct(id: 'p2', name: 'Product B'));
    notifier.addToCart(makeProduct(id: 'p3', name: 'Product C'));

    final state = container.read(cartViewModelProvider);
    expect(state.items.length, 3);
  });
}
