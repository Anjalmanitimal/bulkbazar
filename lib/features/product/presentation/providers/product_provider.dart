import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';

final productProvider =
    StateNotifierProvider<ProductNotifier, AsyncValue<List<ProductEntity>>>(
      (ref) => ProductNotifier(
        ref.read(getProductsUsecaseProvider),
        ref.read(deleteProductUsecaseProvider),
      ),
    );

class ProductNotifier extends StateNotifier<AsyncValue<List<ProductEntity>>> {
  final GetProductsUsecase getProductsUsecase;
  final DeleteProductUsecase deleteProductUsecase;

  ProductNotifier(this.getProductsUsecase, this.deleteProductUsecase)
    : super(const AsyncLoading()) {
    fetchProducts();
  }

  /// FETCH PRODUCTS
  Future<void> fetchProducts() async {
    try {
      state = const AsyncLoading();

      final products = await getProductsUsecase();

      state = AsyncData(products);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  /// DELETE PRODUCT
  Future<void> deleteProduct(String productId) async {
    try {
      await deleteProductUsecase(productId);

      final currentProducts = state.value ?? [];

      state = AsyncData(
        currentProducts.where((p) => p.id != productId).toList(),
      );
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}
