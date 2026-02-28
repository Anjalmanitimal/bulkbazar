import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/product_repository.dart';

import '../../data/repositories/product_repository_impl.dart';
import '../entities/product_entity.dart';

final updateProductUsecaseProvider = Provider((ref) {
  final repo = ref.read(productRepositoryProvider);

  return UpdateProductUsecase(repo);
});

class UpdateProductUsecase {
  final dynamic repository;

  UpdateProductUsecase(this.repository);

  Future<void> call({
    required String productId,
    required String name,
    required String description,
    required String category,
    required File? image,
    required List<PricingEntity> pricing,
  }) {
    return repository.updateProduct(
      productId: productId,
      name: name,
      description: description,
      category: category,
      image: image,
      pricing: pricing,
    );
  }
}
