import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/product/data/models/product_model.dart';

void main() {
  // ─────────────────────────────────────────
  // UNIT TEST 1 — ProductModel.fromJson parses correctly
  // ─────────────────────────────────────────
  test('ProductModel.fromJson should parse all fields correctly', () {
    final json = {
      '_id': 'abc123',
      'name': 'Rice Bag',
      'description': 'Premium quality rice',
      'image': '/uploads/rice.jpg',
      'category': 'Grocery',
      'pricing': [
        {'moq': 5, 'price': 200.0},
      ],
    };

    final model = ProductModel.fromJson(json);

    expect(model.id, 'abc123');
    expect(model.name, 'Rice Bag');
    expect(model.description, 'Premium quality rice');
    expect(model.image, '/uploads/rice.jpg');
    expect(model.category, 'Grocery');
  });

  // ─────────────────────────────────────────
  // UNIT TEST 2 — PricingModel.fromJson parses moq and price
  // ─────────────────────────────────────────
  test('PricingModel.fromJson should parse moq and price correctly', () {
    final json = {'moq': 10, 'price': 99.5};
    final model = PricingModel.fromJson(json);

    expect(model.moq, 10);
    expect(model.price, 99.5);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 3 — ProductModel parses pricing list
  // ─────────────────────────────────────────
  test('ProductModel.fromJson should parse pricing list correctly', () {
    final json = {
      '_id': 'p1',
      'name': 'Sugar',
      'description': 'White sugar',
      'image': '/uploads/sugar.jpg',
      'category': 'Grocery',
      'pricing': [
        {'moq': 1, 'price': 50.0},
        {'moq': 10, 'price': 45.0},
      ],
    };

    final model = ProductModel.fromJson(json);

    expect(model.pricing.length, 2);
    expect(model.pricing.first.moq, 1);
    expect(model.pricing.last.price, 45.0);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 4 — ProductModel uses empty string for missing category
  // ─────────────────────────────────────────
  test(
    'ProductModel.fromJson should use empty string when category is null',
    () {
      final json = {
        '_id': 'p2',
        'name': 'Oil',
        'description': 'Cooking oil',
        'image': '/uploads/oil.jpg',
        'pricing': [
          {'moq': 2, 'price': 120.0},
        ],
      };

      final model = ProductModel.fromJson(json);

      expect(model.category, '');
    },
  );

  // ─────────────────────────────────────────
  // UNIT TEST 5 — PricingModel.toJson serializes correctly
  // ─────────────────────────────────────────
  test('PricingModel.toJson should serialize moq and price correctly', () {
    final model = PricingModel(moq: 5, price: 200.0);
    final json = model.toJson();

    expect(json['moq'], 5);
    expect(json['price'], 200.0);
  });
}
