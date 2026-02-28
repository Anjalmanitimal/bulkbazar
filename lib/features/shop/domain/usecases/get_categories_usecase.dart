import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUsecase {
  final CategoryRepository repository;

  GetCategoriesUsecase(this.repository);

  Future<List<CategoryEntity>> call() {
    return repository.getCategories();
  }
}
