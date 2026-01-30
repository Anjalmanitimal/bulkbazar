import 'package:bulkbazar/features/auth/domain/usecases/register_usecase.dart';
import 'package:bulkbazar/features/auth/domain/repositories/auth_repository.dart';
import 'package:bulkbazar/features/auth/data/models/auth_api_model.dart';
import 'package:bulkbazar/features/auth/domain/entities/auth_entity.dart';
import 'package:bulkbazar/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class FakeAuthEntity extends Fake implements AuthEntity {}

void main() {
  late MockAuthRepository mockRepository;
  late RegisterUsecase usecase;

  setUpAll(() {
    registerFallbackValue(
      AuthEntity(
        id: '0',
        email: 'fake@gmail.com',
        fullName: 'Fake User',
        role: 'customer',
        password: 'fake123',
      ),
    );
  });

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = RegisterUsecase(mockRepository);
  });

  test('returns true when register is successful', () async {
    // Arrange
    final model = AuthApiModel(
      id: '1',
      email: 'test@gmail.com',
      fullName: 'Test User',
      role: 'customer',
      password: 'password123',
    );

    when(
      () => mockRepository.registerUser(any()),
    ).thenAnswer((_) async => const Right(true));

    // Act
    final result = await usecase(model);

    // Assert
    expect(result, true);
    verify(() => mockRepository.registerUser(any())).called(1);
  });

  test('returns false when register fails', () async {
    // Arrange
    final model = AuthApiModel(
      id: '1',
      email: 'test@gmail.com',
      fullName: 'Test User',
      role: 'customer',
      password: 'password123',
    );

    when(
      () => mockRepository.registerUser(any()),
    ).thenAnswer((_) async => Left(const ServerFailure('Register failed')));

    // Act
    final result = await usecase(model);

    // Assert
    expect(result, false);
    verify(() => mockRepository.registerUser(any())).called(1);
  });
}
