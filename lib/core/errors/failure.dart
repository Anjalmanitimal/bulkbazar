abstract class Failure {
  final String message;

  const Failure(this.message);
}

// Generic failure
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// Local / Hive failure
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
