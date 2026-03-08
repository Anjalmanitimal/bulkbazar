import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bulkbazar/features/product/domain/entities/product_entity.dart';
import 'package:bulkbazar/features/product/domain/repositories/product_repository.dart';
import 'package:bulkbazar/features/product/data/repositories/product_repository_impl.dart';
import 'package:bulkbazar/features/product/domain/usecases/add_product_usecase.dart';

/// ─────────────────────────────────────────
/// MOCK
/// ─────────────────────────────────────────
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();

    /// REGISTER fallback for File (needed by mocktail)
    registerFallbackValue(File(''));
    registerFallbackValue(<PricingEntity>[]);
  });

  // ─────────────────────────────────────────
  // COVERS LINES 7, 8, 9
  // Provider registration: ref.read → return AddProductUsecase(repo)
  // ─────────────────────────────────────────
  test(
    'addProductUsecaseProvider should resolve to AddProductUsecase instance',
    () {
      /// OVERRIDE productRepositoryProvider with mock
      /// so no real network/datasource is touched
      final container = ProviderContainer(
        overrides: [
          productRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      /// THIS executes lines 7, 8, 9 of add_product_usecase.dart:
      /// line 7: final repository = ref.read(productRepositoryProvider);
      /// line 8: return AddProductUsecase(repository);
      /// line 9: });
      final usecase = container.read(addProductUsecaseProvider);

      expect(usecase, isA<AddProductUsecase>());
    },
  );

  // ─────────────────────────────────────────
  // BONUS — usecase.call() delegates to repository
  // ─────────────────────────────────────────
  test(
    'AddProductUsecase.call should delegate to repository.addProduct',
    () async {
      when(
        () => mockRepository.addProduct(
          name: any(named: 'name'),
          description: any(named: 'description'),
          image: any(named: 'image'),
          pricing: any(named: 'pricing'),
          category: any(named: 'category'),
        ),
      ).thenAnswer((_) async {});

      final usecase = AddProductUsecase(mockRepository);

      await usecase(
        name: 'Rice',
        description: 'Premium rice',
        image: File('test.jpg'),
        pricing: [PricingEntity(moq: 1, price: 100.0)],
        category: 'Grocery',
      );

      verify(
        () => mockRepository.addProduct(
          name: 'Rice',
          description: 'Premium rice',
          image: any(named: 'image'),
          pricing: any(named: 'pricing'),
          category: 'Grocery',
        ),
      ).called(1);
    },
  );
}
