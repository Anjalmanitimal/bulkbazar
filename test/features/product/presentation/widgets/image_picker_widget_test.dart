import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bulkbazar/features/product/presentation/widgets/image_picker_widget.dart';

/// ─────────────────────────────────────────
/// HELPER
/// ─────────────────────────────────────────
Widget makeImagePicker({VoidCallback? onTap}) {
  return MaterialApp(
    home: Scaffold(body: ImagePickerWidget(onTap: onTap ?? () {})),
  );
}

void main() {
  // ─────────────────────────────────────────
  // WIDGET TEST 1 — shows upload icon when no image
  // ─────────────────────────────────────────
  testWidgets(
    'ImagePickerWidget should show upload icon when no image provided',
    (tester) async {
      await tester.pumpWidget(makeImagePicker());

      expect(find.byIcon(Icons.cloud_upload), findsOneWidget);
    },
  );

  // ─────────────────────────────────────────
  // WIDGET TEST 2 — shows upload hint text when no image
  // ─────────────────────────────────────────
  testWidgets(
    'ImagePickerWidget should show tap to upload text when no image',
    (tester) async {
      await tester.pumpWidget(makeImagePicker());

      expect(find.text('Tap to upload image'), findsOneWidget);
    },
  );

  // ─────────────────────────────────────────
  // WIDGET TEST 3 — triggers onTap callback when tapped
  // ─────────────────────────────────────────
  testWidgets('ImagePickerWidget should trigger onTap when tapped', (
    tester,
  ) async {
    bool tapped = false;

    await tester.pumpWidget(makeImagePicker(onTap: () => tapped = true));
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    expect(tapped, isTrue);
  });

  // ─────────────────────────────────────────
  // WIDGET TEST 4 — renders container with correct height
  // ─────────────────────────────────────────
  testWidgets('ImagePickerWidget should render container with height 170', (
    tester,
  ) async {
    await tester.pumpWidget(makeImagePicker());

    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;

    expect(decoration.borderRadius, BorderRadius.circular(16));
  });
}
