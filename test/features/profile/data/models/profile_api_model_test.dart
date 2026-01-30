import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/profile/data/models/profile_api_model.dart';

void main() {
  test('ProfileApiModel.fromJson should parse correctly', () {
    final json = {
      '_id': '123',
      'fullName': 'Old Man',
      'email': 'oldman@gmail.com',
      'profileImage': '/uploads/profile/test.jpg',
    };

    final model = ProfileApiModel.fromJson(json);

    expect(model.id, '123');
    expect(model.fullName, 'Old Man');
    expect(model.email, 'oldman@gmail.com');
    expect(model.profileImage, '/uploads/profile/test.jpg');
  });
}
