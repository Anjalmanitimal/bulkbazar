import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'core/theme/theme_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BulkBazar',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
