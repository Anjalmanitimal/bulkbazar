import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bulkbazar/features/auth/presentation/pages/signup_screen.dart';

void main() {
  testWidgets('SignupScreen shows all required fields and buttons', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SignupScreen())),
    );

    // ✅ Title
    expect(find.text('Sign up'), findsOneWidget);

    // ✅ Input fields
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // ✅ Signup buttons
    expect(find.text('SIGN UP AS SELLER'), findsOneWidget);
    expect(find.text('SIGN UP AS CUSTOMER'), findsOneWidget);
  });
}
