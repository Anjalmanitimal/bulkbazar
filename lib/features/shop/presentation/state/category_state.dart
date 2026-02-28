import '../../domain/entities/category_entity.dart';

class CategoryState {
  final bool isLoading;
  final List<CategoryEntity> categories;
  final String? selectedCategoryId;
  final String? error;

  const CategoryState({
    required this.isLoading,
    required this.categories,
    required this.selectedCategoryId,
    required this.error,
  });

  factory CategoryState.initial() {
    return const CategoryState(
      isLoading: false,
      categories: [],
      selectedCategoryId: null,
      error: null,
    );
  }

  CategoryState copyWith({
    bool? isLoading,
    List<CategoryEntity>? categories,
    String? selectedCategoryId,
    String? error,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      error: error,
    );
  }
}
