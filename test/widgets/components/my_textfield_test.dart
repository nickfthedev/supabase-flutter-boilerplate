import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/my_textfield.dart';

void main() {
  group('MyTextField Widget Tests', () {
    testWidgets('renders with correct hint text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyTextField(
              controller: TextEditingController(),
              labelText: 'Enter text',
              obscureText: false,
              validator: (value) => null,
            ),
          ),
        ),
      );

      expect(find.text('Enter text'), findsOneWidget);
    });

    testWidgets('obscures text when obscureText is true',
        (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyTextField(
              controller: controller,
              labelText: 'Enter password',
              obscureText: true,
              validator: (value) => null,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'password123');
      expect(find.byType(TextField), findsOneWidget);

      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.obscureText, true);
    });

    testWidgets('updates text when typing', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MyTextField(
              controller: controller,
              labelText: 'Enter text',
              obscureText: false,
              validator: (value) => null,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Hello World');
      expect(controller.text, 'Hello World');
    });
  });
}
