import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bulkbazar/features/auth/presentation/pages/login_screen.dart';

void main() {
  testWidgets('LoginScreen shows login button initially', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LoginScreen())),
    );

    // Login button visible
    expect(find.text('LOGIN'), findsOneWidget);

    // No loader initially
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
