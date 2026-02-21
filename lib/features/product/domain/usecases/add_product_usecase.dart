import 'dart:io';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class AddProductUsecase {
  final ProductRepository repository;

  AddProductUsecase(this.repository);

  Future<void> call({
    required String name,
    required String description,
    required File image,
    required List<PricingEntity> pricing,
  }) {
    return repository.addProduct(
      name: name,
      description: description,
      image: image,
      pricing: pricing,
    );
  }
}
