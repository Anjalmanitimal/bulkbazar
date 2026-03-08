import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/auth/domain/entities/auth_entity.dart';

void main() {
  // ─────────────────────────────────────────
  // UNIT TEST 1 — holds correct values
  // ─────────────────────────────────────────
  test('AuthEntity should hold correct field values', () {
    const entity = AuthEntity(
      id: '123',
      email: 'test@gmail.com',
      fullName: 'Test User',
      role: 'customer',
      password: 'pass123',
    );

    expect(entity.id, '123');
    expect(entity.email, 'test@gmail.com');
    expect(entity.fullName, 'Test User');
    expect(entity.role, 'customer');
    expect(entity.password, 'pass123');
  });

  // ─────────────────────────────────────────
  // UNIT TEST 2 — id is nullable
  // ─────────────────────────────────────────
  test('AuthEntity id should be nullable', () {
    const entity = AuthEntity(
      email: 'test@gmail.com',
      fullName: 'Test User',
      role: 'customer',
      password: 'pass123',
    );

    expect(entity.id, isNull);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 3 — props covers lines 18,19
  // Equatable uses props for equality check
  // ─────────────────────────────────────────
  test('AuthEntity props should contain id, email, fullName, role', () {
    const entity = AuthEntity(
      id: '1',
      email: 'a@gmail.com',
      fullName: 'User A',
      role: 'seller',
      password: 'secret',
    );

    /// THIS LINE executes line 18,19:
    /// List<Object?> get props => [id, email, fullName, role];
    expect(entity.props, [
      entity.id,
      entity.email,
      entity.fullName,
      entity.role,
    ]);
  });

  // ─────────────────────────────────────────
  // UNIT TEST 4 — two entities with same props are equal
  // ─────────────────────────────────────────
  test('Two AuthEntities with same props should be equal', () {
    const e1 = AuthEntity(
      id: '1',
      email: 'same@gmail.com',
      fullName: 'Same User',
      role: 'customer',
      password: 'abc',
    );

    const e2 = AuthEntity(
      id: '1',
      email: 'same@gmail.com',
      fullName: 'Same User',
      role: 'customer',
      password: 'different', // password NOT in props → still equal
    );

    expect(e1, equals(e2));
  });

  // ─────────────────────────────────────────
  // UNIT TEST 5 — two entities with different props are not equal
  // ─────────────────────────────────────────
  test('Two AuthEntities with different email should not be equal', () {
    const e1 = AuthEntity(
      email: 'a@gmail.com',
      fullName: 'User',
      role: 'customer',
      password: 'pass',
    );

    const e2 = AuthEntity(
      email: 'b@gmail.com',
      fullName: 'User',
      role: 'customer',
      password: 'pass',
    );

    expect(e1, isNot(equals(e2)));
  });
}
