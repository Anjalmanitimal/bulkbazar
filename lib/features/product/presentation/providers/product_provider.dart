import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/get_product_usecase.dart';

final productRepositoryProvider = Provider((ref) {
  final datasource = ref.read(productRemoteDatasourceProvider);
  return ProductRepositoryImpl(datasource);
});

final addProductUsecaseProvider = Provider((ref) {
  return AddProductUsecase(ref.read(productRepositoryProvider));
});

final getProductsUsecaseProvider = Provider((ref) {
  return GetProductsUsecase(ref.read(productRepositoryProvider));
});

final productListProvider = FutureProvider((ref) {
  return ref.read(getProductsUsecaseProvider).call();
});
