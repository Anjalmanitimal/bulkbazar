import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_categories_usecase.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../state/category_state.dart';

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, CategoryState>((ref) {
      final usecase = GetCategoriesUsecase(
        ref.read(categoryRepositoryProvider),
      );

      return CategoryViewModel(usecase);
    });

class CategoryViewModel extends StateNotifier<CategoryState> {
  final GetCategoriesUsecase getCategoriesUsecase;

  CategoryViewModel(this.getCategoriesUsecase)
    : super(CategoryState.initial()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      state = state.copyWith(isLoading: true);

      final categories = await getCategoriesUsecase();

      state = state.copyWith(
        isLoading: false,
        categories: categories,
        selectedCategoryId: categories.isNotEmpty ? categories.first.id : null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void selectCategory(String categoryId) {
    state = state.copyWith(selectedCategoryId: categoryId);
  }
}
