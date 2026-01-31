import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget makeTestableWidget(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      home: child,
      routes: {
        '/login': (_) => const Scaffold(body: Text('Login Page')),
        '/signup': (_) => const Scaffold(body: Text('Signup Page')),
        '/dashboard': (_) => const Scaffold(body: Text('Dashboard Page')),
        '/seller-dashboard': (_) =>
            const Scaffold(body: Text('Seller Dashboard')),
      },
    ),
  );
}
