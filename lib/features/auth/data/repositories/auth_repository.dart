import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../datasources/remote/auth_remote_datasource.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepository(
    remoteDatasource: ref.read(authRemoteDatasourceProvider),
  );
});

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDatasource _remoteDatasource;

  AuthRepository({required IAuthRemoteDatasource remoteDatasource})
    : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, AuthEntity>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final result = await _remoteDatasource.loginUser(email, password);

      if (result == null) {
        return Left(ServerFailure("Invalid credentials"));
      }

      return Right(result.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity entity) async {
    try {
      // 🔥 Repository DOES NOT convert to ApiModel
      await _remoteDatasource.registerUser(entity);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
