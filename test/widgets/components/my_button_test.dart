import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/my_button.dart';

void main() {
  group('MyButton Widget Tests', () {
    testWidgets('renders button with correct text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MyButton(
            onPressed: () {},
            text: 'Test Button',
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('calls onTap when pressed', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: MyButton(
            onPressed: () => wasPressed = true,
            text: 'Test Button',
          ),
        ),
      );

      await tester.tap(find.byType(MyButton));
      await tester.pump();

      expect(wasPressed, true);
    });
  });
}
