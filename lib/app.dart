import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/theme_data.dart';

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
