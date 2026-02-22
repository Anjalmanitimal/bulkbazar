import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final remoteDatasource = ref.read(productRemoteDatasourceProvider);
  return ProductRepositoryImpl(remoteDatasource);
});

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  ProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<ProductEntity>> getProducts() async {
    final models = await remoteDatasource.getProducts();

    return models
        .map(
          (model) => ProductEntity(
            id: model.id,
            name: model.name,
            description: model.description,
            image: model.image,
            pricing: model.pricing,
          ),
        )
        .toList();
  }

  @override
  Future<void> addProduct({
    required String name,
    required String description,
    required dynamic image,
    required List<PricingEntity> pricing, // ✅ FIXED TYPE
  }) async {
    await remoteDatasource.addProduct(
      name: name,
      description: description,
      image: image,
      pricing: pricing,
    );
  }
}
