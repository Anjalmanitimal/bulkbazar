import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bulkbazar/features/auth/presentation/pages/signup_screen.dart';

void main() {
  testWidgets('SignupScreen shows already have account text', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SignupScreen())),
    );
    await tester.pump();

    expect(find.text('Already have an account? '), findsOneWidget);
  });

  testWidgets('SignupScreen shows login navigation icon', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SignupScreen())),
    );
    await tester.pump();

    expect(find.byIcon(Icons.arrow_right_alt), findsOneWidget);
  });
}
