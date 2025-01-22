import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter_boilerplate/features/auth/auth_provider.dart';
import 'package:supabase_flutter_boilerplate/features/auth/pages/login_page.dart';

class AuthGuard extends ConsumerWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return user == null ? const LoginScreen() : child;
  }
}

// TODO: Add reverse auth guard for login and signup

// You can wrap any protected screens with the AuthGuard widget to ensure users are authenticated before accessing them.
// To use the auth state in any widget, you can:
// final user = ref.watch(authProvider);
