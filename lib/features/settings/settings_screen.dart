import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter_boilerplate/shared/providers/theme_provider.dart';
import 'package:supabase_flutter_boilerplate/shared/widgets/constrained_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return themeState.when(
      loading: () => ConstrainedScaffold(
        appBar: AppBar(title: Text('Settings')),
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => ConstrainedScaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: const Center(child: Text('Error loading settings')),
      ),
      data: (theme) {
        final isDarkMode = theme == ThemeMode.dark;
        return ConstrainedScaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: ListView(
            children: [
              ListTile(
                title: const Text('Dark Mode'),
                trailing: CupertinoSwitch(
                  value: isDarkMode,
                  onChanged: (value) {
                    ref
                        .read(themeProvider.notifier)
                        .setTheme(value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
