import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_page.dart';
import '../../features/auth/presentation/pages/signup_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/seller/presentation/screens/seller_dashboard_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const signup = '/signup';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const sellerDashboard = '/seller-dashboard'; // ✅ NEW

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingPage(),
    signup: (_) => const SignupScreen(),
    login: (_) => const LoginScreen(),
    dashboard: (_) => const DashboardScreen(),
    sellerDashboard: (_) => const SellerDashboardScreen(), // ✅ NEW
  };
}
