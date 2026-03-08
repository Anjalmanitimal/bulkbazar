import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/product/presentation/widgets/primary_button.dart';

Widget makeButton({
  String text = 'Submit',
  VoidCallback? onPressed,
  bool isLoading = false,
}) {
  return MaterialApp(
    home: Scaffold(
      body: PrimaryButton(
        text: text,
        onPressed: onPressed ?? () {},
        isLoading: isLoading,
      ),
    ),
  );
}

void main() {
  // ─────────────────────────────────────────
  // WIDGET TEST 1 — shows button text
  // ─────────────────────────────────────────
  testWidgets('PrimaryButton should display text', (tester) async {
    await tester.pumpWidget(makeButton(text: 'Save Product'));

    expect(find.text('Save Product'), findsOneWidget);
  });

  // ─────────────────────────────────────────
  // WIDGET TEST 2 — triggers onPressed when tapped
  // ─────────────────────────────────────────
  testWidgets('PrimaryButton should trigger onPressed when tapped', (
    tester,
  ) async {
    bool pressed = false;

    await tester.pumpWidget(makeButton(onPressed: () => pressed = true));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(pressed, isTrue);
  });

  // ─────────────────────────────────────────
  // WIDGET TEST 3 — shows loading indicator when isLoading true
  // ─────────────────────────────────────────
  testWidgets(
    'PrimaryButton should show loading indicator when isLoading is true',
    (tester) async {
      await tester.pumpWidget(makeButton(isLoading: true));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Submit'), findsNothing);
    },
  );

  // ─────────────────────────────────────────
  // WIDGET TEST 4 — button is disabled when isLoading true
  // ─────────────────────────────────────────
  testWidgets('PrimaryButton should be disabled when isLoading is true', (
    tester,
  ) async {
    bool pressed = false;

    await tester.pumpWidget(
      makeButton(isLoading: true, onPressed: () => pressed = true),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(pressed, isFalse);
  });
}
