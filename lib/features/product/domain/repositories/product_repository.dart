import 'dart:io';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts(); // customer

  Future<List<ProductEntity>> getSellerProducts(); // seller

  Future<void> addProduct({
    required String name,
    required String description,
    required File image,
    required List<PricingEntity> pricing,
    required String category,
  });

  Future<void> updateProduct({
    required String productId,
    required String name,
    required String description,
    required File? image,
    required List<PricingEntity> pricing,
    required String category,
  });

  Future<void> deleteProduct(String productId);
}
