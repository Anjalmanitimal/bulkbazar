import 'package:flutter/material.dart';
import 'package:bulkbazar/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('LoginScreen shows email & password fields', (tester) async {
    await tester.pumpWidget(makeTestableWidget(const LoginScreen()));

    expect(find.byKey(const Key('login_email')), findsOneWidget);
    expect(find.byKey(const Key('login_password')), findsOneWidget);
  });

  testWidgets('LoginScreen shows login button', (tester) async {
    await tester.pumpWidget(makeTestableWidget(const LoginScreen()));

    expect(find.byKey(const Key('login_button')), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
  });
}
