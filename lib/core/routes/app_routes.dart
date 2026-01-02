import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_page.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const signup = '/signup';
  static const login = '/login';
  static const dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingPage(),
    signup: (_) => const SignupScreen(),
    login: (_) => const LoginScreen(),
    dashboard: (_) => const DashboardScreen(),
  };
}
