import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/domain/entities/product_entity.dart';
import '../../../product/domain/usecases/get_product_usecase.dart';
import '../../../product/data/repositories/product_repository_impl.dart';

/// STATE
class ProductDetailState {
  final ProductEntity? product;
  final List<ProductEntity> relatedProducts;
  final bool isLoading;

  ProductDetailState({
    this.product,
    this.relatedProducts = const [],
    this.isLoading = false,
  });

  ProductDetailState copyWith({
    ProductEntity? product,
    List<ProductEntity>? relatedProducts,
    bool? isLoading,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// PROVIDER
final productDetailViewModelProvider =
    StateNotifierProvider<ProductDetailViewModel, ProductDetailState>((ref) {
      final repo = ref.read(productRepositoryProvider);
      final usecase = GetProductsUsecase(repo);

      return ProductDetailViewModel(usecase);
    });

/// VIEWMODEL
class ProductDetailViewModel extends StateNotifier<ProductDetailState> {
  final GetProductsUsecase getProductsUsecase;

  ProductDetailViewModel(this.getProductsUsecase) : super(ProductDetailState());

  Future<void> loadProduct(ProductEntity product) async {
    state = state.copyWith(product: product, isLoading: true);

    final allProducts = await getProductsUsecase();

    final related = allProducts
        .where((p) => p.category == product.category && p.id != product.id)
        .toList();

    state = state.copyWith(relatedProducts: related, isLoading: false);
  }
}
