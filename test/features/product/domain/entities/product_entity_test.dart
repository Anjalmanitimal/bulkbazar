import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/product/domain/entities/product_entity.dart';

void main() {
  // ─────────────────────────────────────────
  // UNIT TEST 1 — ProductEntity holds correct values
  // ─────────────────────────────────────────
  test('ProductEntity should hold correct field values', () {
    final entity = ProductEntity(
      id: 'prod1',
      name: 'Rice Bag',
      description: 'Premium quality rice',
      image: '/uploads/rice.jpg',
      category: 'Grocery',
      pricing: [PricingEntity(moq: 5, price: 200.0)],
    );

    expect(entity.id, 'prod1');
    expect(entity.name, 'Rice Bag');
    expect(entity.description, 'Premium quality rice');
    expect(entity.image, '/uploads/rice.jpg');
    expect(entity.category, 'Grocery');
  });

  // ─────────────────────────────────────────
  // UNIT TEST 2 — PricingEntity holds moq and price
  // ─────────────────────────────────────────
  test('PricingEntity should hold correct moq and price', () {
    final pricing = PricingEntity(moq: 10, price: 500.0);

    expect(pricing.moq, 10);
    expect(pricing.price, 500.0);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 3 — ProductEntity supports multiple pricing tiers
  // ─────────────────────────────────────────
  test('ProductEntity should support multiple pricing tiers', () {
    final entity = ProductEntity(
      id: 'prod2',
      name: 'Sugar',
      description: 'White sugar',
      image: '/uploads/sugar.jpg',
      category: 'Grocery',
      pricing: [
        PricingEntity(moq: 1, price: 100.0),
        PricingEntity(moq: 10, price: 90.0),
        PricingEntity(moq: 50, price: 80.0),
      ],
    );

    expect(entity.pricing.length, 3);
    expect(entity.pricing.first.moq, 1);
    expect(entity.pricing.last.price, 80.0);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 4 — first pricing tier is accessible
  // ─────────────────────────────────────────
  test('ProductEntity.pricing.first should return correct moq and price', () {
    final entity = ProductEntity(
      id: 'prod3',
      name: 'Oil',
      description: 'Cooking oil',
      image: '/uploads/oil.jpg',
      category: 'Grocery',
      pricing: [PricingEntity(moq: 2, price: 150.0)],
    );

    expect(entity.pricing.first.moq, 2);
    expect(entity.pricing.first.price, 150.0);
  });
}
