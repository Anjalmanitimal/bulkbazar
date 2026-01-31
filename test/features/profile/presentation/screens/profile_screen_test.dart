import 'package:flutter/material.dart';
import 'package:bulkbazar/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('ProfileScreen shows app bar with title', (tester) async {
    await tester.pumpWidget(makeTestableWidget(const ProfileScreen()));

    expect(find.text('My Profile'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('ProfileScreen shows loading indicator initially', (
    tester,
  ) async {
    await tester.pumpWidget(makeTestableWidget(const ProfileScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
