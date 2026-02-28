import 'dart:io';

import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts();

  Future<void> addProduct({
    required String name,
    required String description,
    required String category,
    required File image,
    required List<PricingEntity> pricing,
  });

  Future<void> updateProduct({
    required String productId,
    required String name,
    required String description,
    required String category,
    required File? image,
    required List<PricingEntity> pricing,
  });
}
