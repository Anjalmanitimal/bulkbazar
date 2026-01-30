import 'package:bulkbazar/features/auth/domain/usecases/login_usecase.dart';
import 'package:bulkbazar/features/auth/domain/entities/auth_entity.dart';
import 'package:bulkbazar/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late LoginUsecase usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LoginUsecase(mockRepository);
  });

  test('returns AuthEntity when login is successful', () async {
    // Arrange
    const authEntity = AuthEntity(
      id: '123',
      email: 'test@gmail.com',
      fullName: 'Test User',
      role: 'customer',
      password: 'password123', // ✅ REQUIRED
    );

    when(
      () => mockRepository.loginUser(any(), any()),
    ).thenAnswer((_) async => Right(authEntity));

    // Act
    final result = await usecase(
      email: 'test@gmail.com',
      password: 'password123',
    );

    // Assert
    expect(result, authEntity);
    verify(() => mockRepository.loginUser(any(), any())).called(1);
  });
}
