import 'package:bulkbazar/features/auth/domain/usecases/login_usecase.dart';
import 'package:bulkbazar/features/auth/domain/repositories/auth_repository.dart';
import 'package:bulkbazar/core/errors/failure.dart'; // ✅ IMPORT FAILURE
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

  test('returns null when login fails', () async {
    // Arrange
    when(
      () => mockRepository.loginUser(any(), any()),
    ).thenAnswer((_) async => Left(const ServerFailure('Login failed')));

    // Act
    final result = await usecase(
      email: 'wrong@gmail.com',
      password: 'wrongpass',
    );

    // Assert
    expect(result, null);
    verify(() => mockRepository.loginUser(any(), any())).called(1);
  });
}
