import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter_boilerplate/features/profile/profile_model.dart';
import 'package:supabase_flutter_boilerplate/features/auth/auth_provider.dart';
import 'package:supabase_flutter_boilerplate/features/profile/profile_provider.dart';
import 'package:supabase_flutter_boilerplate/shared/validators/common_validator.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/constrained_scaffold.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/my_button.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/my_textfield.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.watch(authProvider);
    final profile = ref.watch(profileProvider(user?.id ?? ''));

    try {
      if (profile.value?.username != _usernameController.text) {
        await Profile.updateProfile(
          userId: user?.id ?? '',
          username: _usernameController.text,
        );

        ref.invalidate(profileProvider(user?.id ?? ''));

        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    final profile = ref.watch(profileProvider(user?.id ?? ''));

    _usernameController.text = profile.value?.username ?? '';

    return ConstrainedScaffold(
      appBar: AppBar(
        title: Text('Edit Account',
            style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Edit your Account',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 16.0),
                MyTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                  validator: validateIsNotEmpty,
                ),
                const SizedBox(height: 8.0),
                MyButton(
                  onPressed: _updateProfile,
                  text: 'Save',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
