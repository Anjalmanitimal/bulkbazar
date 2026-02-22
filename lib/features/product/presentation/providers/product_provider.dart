import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_product_usecase.dart';

final productProvider =
    StateNotifierProvider<ProductNotifier, AsyncValue<List<ProductEntity>>>(
      (ref) => ProductNotifier(ref.read(getProductsUsecaseProvider)),
    );

class ProductNotifier extends StateNotifier<AsyncValue<List<ProductEntity>>> {
  final GetProductsUsecase getProductsUsecase;

  ProductNotifier(this.getProductsUsecase) : super(const AsyncLoading()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      state = const AsyncLoading();

      final products = await getProductsUsecase();

      state = AsyncData(products);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}
