import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/product_repository.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../entities/product_entity.dart';

final addProductUsecaseProvider = Provider<AddProductUsecase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return AddProductUsecase(repository);
});

class AddProductUsecase {
  final ProductRepository repository;

  AddProductUsecase(this.repository);

  Future<void> call({
    required String name,
    required String description,
    required dynamic image,
    required List<PricingEntity> pricing,
    required String category,
  }) async {
    await repository.addProduct(
      name: name,
      description: description,
      image: image,
      pricing: pricing,
      category: category,
    );
  }
}
