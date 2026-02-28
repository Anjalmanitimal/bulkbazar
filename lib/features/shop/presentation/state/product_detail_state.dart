import '../../../product/domain/entities/product_entity.dart';

class ProductDetailState {
  final ProductEntity? product;
  final List<ProductEntity> relatedProducts;
  final bool isLoading;
  final String? error;

  ProductDetailState({
    this.product,
    this.relatedProducts = const [],
    this.isLoading = false,
    this.error,
  });

  factory ProductDetailState.initial() {
    return ProductDetailState(
      product: null,
      relatedProducts: [],
      isLoading: false,
      error: null,
    );
  }

  ProductDetailState copyWith({
    ProductEntity? product,
    List<ProductEntity>? relatedProducts,
    bool? isLoading,
    String? error,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
