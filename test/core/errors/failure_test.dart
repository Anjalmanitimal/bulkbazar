import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/core/errors/failure.dart';

void main() {
  // ─────────────────────────────────────────
  // UNIT TEST 1 — ServerFailure holds message
  // ─────────────────────────────────────────
  test('ServerFailure should hold correct message', () {
    const failure = ServerFailure('Server error occurred');

    expect(failure.message, 'Server error occurred');
    expect(failure, isA<Failure>());
  });

  // ─────────────────────────────────────────
  // UNIT TEST 2 — CacheFailure covers line 14
  // ─────────────────────────────────────────
  test('CacheFailure should hold correct message', () {
    /// THIS executes line 14:
    /// class CacheFailure extends Failure { const CacheFailure(super.message); }
    const failure = CacheFailure('Cache read failed');

    expect(failure.message, 'Cache read failed');
    expect(failure, isA<Failure>());
  });

  // ─────────────────────────────────────────
  // UNIT TEST 3 — NetworkFailure covers line 19
  // ─────────────────────────────────────────
  test('NetworkFailure should hold correct message', () {
    /// THIS executes line 19:
    /// class NetworkFailure extends Failure { const NetworkFailure(super.message); }
    const failure = NetworkFailure('No internet connection');

    expect(failure.message, 'No internet connection');
    expect(failure, isA<Failure>());
  });

  // ─────────────────────────────────────────
  // UNIT TEST 4 — all failures are distinct types
  // ─────────────────────────────────────────
  test('Failure subclasses should be distinct types', () {
    const server = ServerFailure('s');
    const cache = CacheFailure('c');
    const network = NetworkFailure('n');

    expect(server, isA<ServerFailure>());
    expect(cache, isA<CacheFailure>());
    expect(network, isA<NetworkFailure>());

    expect(server, isNot(isA<CacheFailure>()));
    expect(cache, isNot(isA<NetworkFailure>()));
  });
}
