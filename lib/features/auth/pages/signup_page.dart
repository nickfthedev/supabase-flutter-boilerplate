import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/constrained_scaffold.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/my_button.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/my_textfield.dart';
import 'package:supabase_flutter_boilerplate/features/auth/auth_provider.dart';
import 'package:supabase_flutter_boilerplate/shared/validators/user_validator.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await ref.read(authProvider.notifier).signUp(
              _emailController.text,
              _passwordController.text,
            );
        // Redirect to login page
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Account created successfully. Please check your email for the verification link.')),
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
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedScaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Create a new account',
            style: TextStyle(color: Theme.of(context).primaryColor),
          )),
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
                  validator: validateEmail),
              const SizedBox(height: 16),
              MyTextField(
                controller: _passwordController,
                obscureText: true,
                labelText: 'Password',
                validator: validatePassword,
              ),
              const SizedBox(height: 16),
              MyTextField(
                controller: _confirmPasswordController,
                obscureText: true,
                labelText: 'Confirm Password',
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              MyButton(
                text: _isLoading ? 'Loading...' : 'Create Account',
                onPressed: _isLoading ? () {} : _signup,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
