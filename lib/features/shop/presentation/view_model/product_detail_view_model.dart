import 'package:bulkbazar/features/shop/presentation/state/product_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/domain/entities/product_entity.dart';
import '../../../product/domain/usecases/get_product_usecase.dart';

final productDetailViewModelProvider =
    StateNotifierProvider<ProductDetailViewModel, ProductDetailState>((ref) {
      final getProducts = ref.read(getProductsUsecaseProvider);

      return ProductDetailViewModel(getProducts);
    });

class ProductDetailViewModel extends StateNotifier<ProductDetailState> {
  final GetProductsUsecase getProductsUsecase;

  ProductDetailViewModel(this.getProductsUsecase)
    : super(ProductDetailState.initial());

  Future<void> loadProduct(ProductEntity product) async {
    try {
      state = state.copyWith(isLoading: true, product: product);

      final allProducts = await getProductsUsecase();

      final related = allProducts
          .where((p) => p.category == product.category && p.id != product.id)
          .toList();

      state = state.copyWith(isLoading: false, relatedProducts: related);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
