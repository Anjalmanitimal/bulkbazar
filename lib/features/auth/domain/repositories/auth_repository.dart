import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, AuthEntity>> loginUser(String email, String password);

  Future<Either<Failure, bool>> registerUser(AuthEntity entity);
}
