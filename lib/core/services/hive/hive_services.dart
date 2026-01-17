import 'package:hive/hive.dart';
import '../../../features/auth/data/models/auth_hive_model.dart';
import '../../constants/hive_table_constants.dart';

class HiveService {
  static Box<AuthHiveModel> get _userBox =>
      Hive.box<AuthHiveModel>(HiveTableConstants.usersBox);

  // Save user
  static Future<void> addUser(AuthHiveModel user) async {
    await _userBox.add(user);
  }

  // Check if email exists
  static bool emailExists(String email) {
    return _userBox.values.any((user) => user.email == email);
  }

  // Validate login
  static bool validateUser(String email, String password) {
    return _userBox.values.any(
      (user) => user.email == email && user.password == password,
    );
  }
}
