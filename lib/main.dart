import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/models/user_hive_model.dart';
import 'core/constants/hive_table_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(UserHiveModelAdapter().typeId)) {
    Hive.registerAdapter(UserHiveModelAdapter());
  }

  await Hive.openBox<UserHiveModel>(HiveTableConstants.usersBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
