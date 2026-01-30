import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/profile/domain/entities/profile_entity.dart';

void main() {
  test('ProfileEntity should hold correct values', () {
    final entity = ProfileEntity(
      id: '1',
      fullName: 'Test User',
      email: 'test@gmail.com',

      profileImage: '/img.jpg',
    );

    expect(entity.fullName, 'Test User');
    expect(entity.email, 'test@gmail.com');

    expect(entity.profileImage, '/img.jpg');
  });
}
