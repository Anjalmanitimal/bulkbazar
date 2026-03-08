import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/product/presentation/widgets/product_textfield.dart';

/// ─────────────────────────────────────────
/// HELPER
/// ─────────────────────────────────────────
Widget makeTextField({
  required TextEditingController controller,
  required String label,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ProductTextField(
            controller: controller,
            label: label,
            keyboardType: keyboardType,
            validator: validator,
          ),
        ),
      ),
    ),
  );
}

void main() {
  // ─────────────────────────────────────────
  // WIDGET TEST 1 — shows label text
  // ─────────────────────────────────────────
  testWidgets('ProductTextField should display label text', (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      makeTextField(controller: controller, label: 'Product Name'),
    );

    expect(find.text('Product Name'), findsOneWidget);
  });

  // ─────────────────────────────────────────
  // WIDGET TEST 2 — accepts text input
  // ─────────────────────────────────────────
  testWidgets('ProductTextField should accept and display typed text', (
    tester,
  ) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      makeTextField(controller: controller, label: 'Description'),
    );

    await tester.enterText(find.byType(TextFormField), 'Fresh Rice');
    await tester.pump();

    expect(find.text('Fresh Rice'), findsOneWidget);
  });

  // ─────────────────────────────────────────
  // WIDGET TEST 3 — shows validation error message
  // ─────────────────────────────────────────
  testWidgets('ProductTextField should show validator error message', (
    tester,
  ) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: ProductTextField(
                controller: controller,
                label: 'Price',
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Price is required' : null,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Price is required'), findsOneWidget);
  });
}
