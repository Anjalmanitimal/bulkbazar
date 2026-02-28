import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';
import '../../data/repositories/product_repository_impl.dart';

final getProductsUsecaseProvider = Provider((ref) {
  final repo = ref.read(productRepositoryProvider);
  return GetProductsUsecase(repo);
});

class GetProductsUsecase {
  final ProductRepository repository;

  GetProductsUsecase(this.repository);

  Future<List<ProductEntity>> call() {
    return repository.getProducts();
  }
}
