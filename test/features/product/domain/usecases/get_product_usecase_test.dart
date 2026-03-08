import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bulkbazar/features/product/domain/usecases/get_product_usecase.dart';
import 'package:bulkbazar/features/product/domain/repositories/product_repository.dart';
import 'package:bulkbazar/features/product/domain/entities/product_entity.dart';

/// ─────────────────────────────────────────
/// MOCK
/// ─────────────────────────────────────────
class MockProductRepository extends Mock implements ProductRepository {}

/// ─────────────────────────────────────────
/// HELPER
/// ─────────────────────────────────────────
ProductEntity makeProduct({String id = 'p1', String name = 'Rice'}) {
  return ProductEntity(
    id: id,
    name: name,
    description: 'A test product',
    image: '/uploads/test.jpg',
    category: 'Grocery',
    pricing: [PricingEntity(moq: 1, price: 100.0)],
  );
}

void main() {
  late MockProductRepository mockRepository;
  late GetProductsUsecase usecase;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetProductsUsecase(mockRepository);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 1 — returns list on success
  // ─────────────────────────────────────────
  test(
    'GetProductsUsecase should return list of products on success',
    () async {
      final products = [
        makeProduct(id: 'p1'),
        makeProduct(id: 'p2', name: 'Sugar'),
      ];

      when(
        () => mockRepository.getProducts(),
      ).thenAnswer((_) async => products);

      final result = await usecase();

      expect(result.length, 2);
      expect(result.first.id, 'p1');
      verify(() => mockRepository.getProducts()).called(1);
    },
  );

  // ─────────────────────────────────────────
  // UNIT TEST 2 — returns empty list when no products
  // ─────────────────────────────────────────
  test(
    'GetProductsUsecase should return empty list when no products exist',
    () async {
      when(() => mockRepository.getProducts()).thenAnswer((_) async => []);

      final result = await usecase();

      expect(result, isEmpty);
      verify(() => mockRepository.getProducts()).called(1);
    },
  );

  // ─────────────────────────────────────────
  // UNIT TEST 3 — throws when repository throws
  // ─────────────────────────────────────────
  test('GetProductsUsecase should throw when repository throws', () async {
    when(
      () => mockRepository.getProducts(),
    ).thenThrow(Exception('Network error'));

    expect(() => usecase(), throwsException);
  });
}
