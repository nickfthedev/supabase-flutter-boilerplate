import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter_boilerplate/shared/config/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_flutter_boilerplate/shared/config/supabase_config.dart';
import 'package:flutter/material.dart';

// TODO: Add custom error messages for signup and login

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  final navigatorKey = GlobalKey<NavigatorState>();
  return AuthNotifier(navigatorKey);
});

class AuthNotifier extends StateNotifier<User?> {
  final GlobalKey<NavigatorState> navigatorKey;

  AuthNotifier(this.navigatorKey)
      : super(SupabaseConfig.client.auth.currentUser) {
    // Listen for auth state changes
    SupabaseConfig.client.auth.onAuthStateChange.listen((data) {
      state = data.session?.user;

      final event = data.event;
      if (event == AuthChangeEvent.passwordRecovery) {
        _handlePasswordRecovery();
      } else if (event == AuthChangeEvent.signedOut) {
        _handleSignOut();
      }
    });
  }

  void _handlePasswordRecovery() {
    Future.delayed(const Duration(milliseconds: 100), () {
      final currentRoute =
          ModalRoute.of(navigatorKey.currentContext!)?.settings.name;
      if (currentRoute != '/reset-password') {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/reset-password',
          (route) => false,
        );
      }
    });
  }

  void _handleSignOut() {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      const SnackBar(content: Text('You have been signed out.')),
    );
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/main-account',
      (route) => false,
    );
  }

  Future<void> signIn(String email, String password) async {
    try {
      await SupabaseConfig.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await SupabaseConfig.client.auth.signUp(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await SupabaseConfig.client.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await SupabaseConfig.client.auth.resetPasswordForEmail(
        email,
        redirectTo: AppConfig.redirectUrlWeb,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await SupabaseConfig.client.auth.updateUser(
        UserAttributes(
          password: newPassword,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
