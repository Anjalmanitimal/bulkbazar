import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/domain/entities/product_entity.dart';
import '../../../product/domain/usecases/get_product_usecase.dart';
import '../../../product/data/repositories/product_repository_impl.dart';

class ProductState {
  final bool isLoading;
  final List<ProductEntity> products;
  final String? error;

  const ProductState({
    required this.isLoading,
    required this.products,
    required this.error,
  });

  factory ProductState.initial() {
    return const ProductState(isLoading: false, products: [], error: null);
  }

  ProductState copyWith({
    bool? isLoading,
    List<ProductEntity>? products,
    String? error,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      error: error,
    );
  }
}

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>((ref) {
      final usecase = GetProductsUsecase(ref.read(productRepositoryProvider));

      return ProductViewModel(usecase);
    });

class ProductViewModel extends StateNotifier<ProductState> {
  final GetProductsUsecase getProductsUsecase;

  ProductViewModel(this.getProductsUsecase) : super(ProductState.initial()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      state = state.copyWith(isLoading: true);

      final products = await getProductsUsecase();

      state = state.copyWith(isLoading: false, products: products);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
