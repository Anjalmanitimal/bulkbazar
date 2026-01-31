import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bulkbazar/features/auth/presentation/pages/signup_screen.dart';

void main() {
  testWidgets('SignupScreen shows navigation text', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SignupScreen())),
    );

    expect(find.text('Already have an account? '), findsOneWidget);
    expect(find.byIcon(Icons.arrow_right_alt), findsOneWidget);
  });
}
