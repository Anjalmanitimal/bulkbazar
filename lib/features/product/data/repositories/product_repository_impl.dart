import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final remoteDatasource = ref.read(productRemoteDatasourceProvider);
  return ProductRepositoryImpl(remoteDatasource);
});

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  ProductRepositoryImpl(this.remoteDatasource);

  /// ==========================================
  /// CUSTOMER → GET ALL PRODUCTS
  /// ==========================================
  @override
  Future<List<ProductEntity>> getProducts() async {
    final models = await remoteDatasource.getAllProducts();

    return models.map((model) {
      return ProductEntity(
        id: model.id,
        name: model.name,
        description: model.description,
        image: model.image,
        category: model.category,
        pricing: model.pricing,
      );
    }).toList();
  }

  /// ==========================================
  /// SELLER → GET SELLER PRODUCTS
  /// ==========================================
  @override
  Future<List<ProductEntity>> getSellerProducts() async {
    final models = await remoteDatasource.getSellerProducts();

    return models.map((model) {
      return ProductEntity(
        id: model.id,
        name: model.name,
        description: model.description,
        image: model.image,
        category: model.category,
        pricing: model.pricing,
      );
    }).toList();
  }

  /// ==========================================
  /// ADD PRODUCT
  /// ==========================================
  @override
  Future<void> addProduct({
    required String name,
    required String description,
    required File image,
    required List<PricingEntity> pricing,
    required String category,
  }) async {
    await remoteDatasource.addProduct(
      name: name,
      description: description,
      image: image,
      pricing: pricing,
      category: category,
    );
  }

  /// ==========================================
  /// UPDATE PRODUCT
  /// ==========================================
  @override
  Future<void> updateProduct({
    required String productId,
    required String name,
    required String description,
    required File? image,
    required List<PricingEntity> pricing,
    required String category,
  }) async {
    await remoteDatasource.updateProduct(
      productId: productId,
      name: name,
      description: description,
      image: image,
      pricing: pricing,
      category: category,
    );
  }

  /// ==========================================
  /// DELETE PRODUCT
  /// ==========================================
  @override
  Future<void> deleteProduct(String productId) async {
    await remoteDatasource.deleteProduct(productId);
  }
}
