import '../entities/product_entity.dart';
import 'dart:io';

abstract class ProductRepository {
  Future<void> addProduct({
    required String name,
    required String description,
    required File image,
    required List<PricingEntity> pricing,
  });

  Future<List<ProductEntity>> getProducts();
}
