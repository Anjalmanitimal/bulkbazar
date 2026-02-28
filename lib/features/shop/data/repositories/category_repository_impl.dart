import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../../../product/data/datasources/product_remote_datasource.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final productDatasource = ref.read(productRemoteDatasourceProvider);

  return CategoryRepositoryImpl(productDatasource);
});

class CategoryRepositoryImpl implements CategoryRepository {
  final ProductRemoteDatasource datasource;

  CategoryRepositoryImpl(this.datasource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final products = await datasource.getAllProducts();

    final Set<String> categorySet = {};

    for (var product in products) {
      categorySet.add(product.category);
    }

    return categorySet
        .map((name) => CategoryEntity(id: name, name: name))
        .toList();
  }
}
