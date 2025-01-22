import 'package:flutter/material.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/constrained_scaffold.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/my_button.dart';
import 'package:supabase_flutter_boilerplate/main.dart';
import 'package:supabase_flutter_boilerplate/features/auth/pages/forgot_password_page.dart';
import 'package:supabase_flutter_boilerplate/features/auth/pages/signup_page.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/my_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter_boilerplate/features/auth/auth_provider.dart';
import 'package:supabase_flutter_boilerplate/shared/validators/common_validator.dart';
import 'package:supabase_flutter_boilerplate/shared/validators/user_validator.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await ref.read(authProvider.notifier).signIn(
              _emailController.text,
              _passwordController.text,
            );
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedScaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Login',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(
                controller: _emailController,
                labelText: 'Email',
                validator: validateEmail,
              ),
              const SizedBox(height: 16),
              MyTextField(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
                // We don't want to use the validator here because password is already validated in the signup page
                validator: validateIsNotEmpty,
              ),
              const SizedBox(height: 24),
              MyButton(
                text: _isLoading ? 'Loading...' : 'Login',
                onPressed: _isLoading ? () {} : _login,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen()),
                  );
                },
                child: const Text('Forgot Password?'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()),
                  );
                },
                child: const Text('Create a new account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
