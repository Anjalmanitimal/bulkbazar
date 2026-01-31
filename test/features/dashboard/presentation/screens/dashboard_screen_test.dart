import 'package:flutter/material.dart';
import 'package:bulkbazar/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('DashboardScreen shows BottomNavigationBar', (tester) async {
    await tester.pumpWidget(makeTestableWidget(const DashboardScreen()));

    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('DashboardScreen has 4 navigation items', (tester) async {
    await tester.pumpWidget(makeTestableWidget(const DashboardScreen()));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Shop'), findsOneWidget);
    expect(find.text('Bag'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('DashboardScreen has AppBar', (tester) async {
    await tester.pumpWidget(makeTestableWidget(const DashboardScreen()));

    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('DashboardScreen shows Home icon', (tester) async {
    await tester.pumpWidget(makeTestableWidget(const DashboardScreen()));

    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
  });

  testWidgets('DashboardScreen tapping Shop tab changes screen', (
    tester,
  ) async {
    await tester.pumpWidget(makeTestableWidget(const DashboardScreen()));

    // Initially on Home tab
    final bottomNav = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );
    expect(bottomNav.currentIndex, 0);

    // Tap on Shop tab
    await tester.tap(find.text('Shop'));
    await tester.pump();

    // Should now be on Shop tab (index 1)
    final updatedBottomNav = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );
    expect(updatedBottomNav.currentIndex, 1);
  });

  testWidgets('DashboardScreen navigation items have correct icons', (
    tester,
  ) async {
    await tester.pumpWidget(makeTestableWidget(const DashboardScreen()));

    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    expect(find.byIcon(Icons.storefront_outlined), findsOneWidget);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsWidgets);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);
  });
}
