import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../constants/hive_table_constants.dart';

/// Provider
final userSessionServiceProvider = Provider<UserSessionService>((ref) {
  return UserSessionService();
});

class UserSessionService {
  /// Save logged-in user session
  Future<void> saveUserSession({
    required String userId,
    required String email,
    required String role,
  }) async {
    final box = Hive.box(HiveTableConstants.sessionBox);

    await box.put('userId', userId);
    await box.put('email', email);
    await box.put('role', role);
    await box.put('isLoggedIn', true);
  }

  /// Check login status
  bool isLoggedIn() {
    final box = Hive.box(HiveTableConstants.sessionBox);
    return box.get('isLoggedIn', defaultValue: false);
  }

  /// Get role (seller / customer)
  String? getUserRole() {
    final box = Hive.box(HiveTableConstants.sessionBox);
    return box.get('role');
  }

  /// Clear session on logout
  Future<void> clearUserSession() async {
    final box = Hive.box(HiveTableConstants.sessionBox);
    await box.clear();
  }
}
