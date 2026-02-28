import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/product_repository.dart';
import '../../data/repositories/product_repository_impl.dart';

/// PROVIDER
final deleteProductUsecaseProvider = Provider<DeleteProductUsecase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return DeleteProductUsecase(repository);
});

/// USECASE
class DeleteProductUsecase {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  Future<void> call(String productId) async {
    await repository.deleteProduct(productId);
  }
}
