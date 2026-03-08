import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/auth/presentation/widgets/dot_indicator.dart';

Widget makeDot({required bool isActive}) {
  return MaterialApp(
    home: Scaffold(
      body: Center(child: DotIndicator(isActive: isActive)),
    ),
  );
}

void main() {
  // ─────────────────────────────────────────
  // WIDGET TEST 1 — renders when active
  // ─────────────────────────────────────────
  testWidgets('DotIndicator should render when isActive is true', (
    tester,
  ) async {
    await tester.pumpWidget(makeDot(isActive: true));

    expect(find.byType(DotIndicator), findsOneWidget);
  });

  // ─────────────────────────────────────────
  // WIDGET TEST 2 — renders when inactive
  // ─────────────────────────────────────────
  testWidgets('DotIndicator should render when isActive is false', (
    tester,
  ) async {
    await tester.pumpWidget(makeDot(isActive: false));

    expect(find.byType(DotIndicator), findsOneWidget);
  });

  // ─────────────────────────────────────────
  // WIDGET TEST 3 — uses AnimatedContainer
  // ─────────────────────────────────────────
  testWidgets('DotIndicator should use AnimatedContainer', (tester) async {
    await tester.pumpWidget(makeDot(isActive: true));

    expect(find.byType(AnimatedContainer), findsOneWidget);
  });

  // ─────────────────────────────────────────
  // WIDGET TEST 4 — active dot is wider than inactive
  // ─────────────────────────────────────────
  testWidgets('DotIndicator active should be wider than inactive', (
    tester,
  ) async {
    await tester.pumpWidget(makeDot(isActive: true));
    await tester.pump();

    final activeDot = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );

    await tester.pumpWidget(makeDot(isActive: false));
    await tester.pump();

    final inactiveDot = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );

    /// active width=20, inactive width=8
    expect(activeDot.constraints, isNot(equals(inactiveDot.constraints)));
  });
}
