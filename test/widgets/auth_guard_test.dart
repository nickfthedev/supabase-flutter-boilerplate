import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter_boilerplate/features/auth/widgets/auth_guard.dart';
import 'package:supabase_flutter_boilerplate/features/auth/auth_provider.dart';
import 'package:supabase_flutter_boilerplate/features/auth/pages/login_page.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Mock AuthNotifier
class MockAuthNotifier extends StateNotifier<User?>
    with Mock
    implements AuthNotifier {
  MockAuthNotifier(super.state);
}

void main() {
  group('AuthGuard', () {
    late MockAuthNotifier mockAuthNotifier;

    setUp(() {
      mockAuthNotifier = MockAuthNotifier(null);
    });

    testWidgets('shows login screen when user is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: AuthGuard(
              child: Text('Protected Content'),
            ),
          ),
        ),
      );

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('Protected Content'), findsNothing);
    });

    testWidgets('shows child when user is authenticated',
        (WidgetTester tester) async {
      // Mock authenticated user
      final user = User(
        id: '123',
        appMetadata: {},
        userMetadata: {},
        aud: 'authenticated',
        createdAt: DateTime.now().toString(),
      );
      mockAuthNotifier = MockAuthNotifier(user);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: AuthGuard(
              child: Text('Protected Content'),
            ),
          ),
        ),
      );

      expect(find.byType(LoginScreen), findsNothing);
      expect(find.text('Protected Content'), findsOneWidget);
    });
  });
}
