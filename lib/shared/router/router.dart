import 'package:flutter/material.dart';
import 'package:supabase_flutter_boilerplate/features/auth/pages/forgot_password_page.dart';
import 'package:supabase_flutter_boilerplate/features/auth/pages/login_page.dart';
import 'package:supabase_flutter_boilerplate/features/auth/pages/signup_page.dart';
import 'package:supabase_flutter_boilerplate/features/auth/pages/update_password_page.dart';
import 'package:supabase_flutter_boilerplate/features/auth/widgets/auth_guard.dart';
import 'package:supabase_flutter_boilerplate/features/profile/profile_edit_page.dart';
import 'package:supabase_flutter_boilerplate/features/profile/profile_page.dart';
import 'package:supabase_flutter_boilerplate/features/settings/settings_screen.dart';
import 'package:supabase_flutter_boilerplate/main.dart';

class AppRouter {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => MainScreen(),
    '/settings': (context) => const SettingsScreen(),
    // Shows the accounts screen in the main screen with bottom bar
    '/main-account': (context) => MainScreen(initialIndex: 1),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignupScreen(),
    '/account': (context) => const AuthGuard(child: ProfileScreen()),
    '/account-edit': (context) => const AuthGuard(child: ProfileEditScreen()),
    '/forgot-password': (context) => const ForgotPasswordScreen(),
    '/reset-password': (context) => const UpdatePasswordScreen(),
  };
}
