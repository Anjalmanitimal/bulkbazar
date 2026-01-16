import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../constants/hive_table_constants.dart';

final userSessionServiceProvider = Provider<UserSessionService>((ref) {
  return UserSessionService();
});

class UserSessionService {
  Box get _box => Hive.box(HiveTableConstants.sessionBox);

  Future<void> saveUserSession({
    required String userId,
    required String email,
    required String fullName,
    required String role,
  }) async {
    await _box.put('userId', userId);
    await _box.put('email', email);
    await _box.put('fullName', fullName);
    await _box.put('role', role);
  }

  Future<void> clearUserSession() async {
    await _box.clear();
  }
}
