import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';
import '../../data/repositories/product_repository_impl.dart';

final getProductsUsecaseProvider = Provider<GetProductsUsecase>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return GetProductsUsecase(repository);
});

class GetProductsUsecase {
  final ProductRepository repository;

  GetProductsUsecase(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getProducts();
  }
}
