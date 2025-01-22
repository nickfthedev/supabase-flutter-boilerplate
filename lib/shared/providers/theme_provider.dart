import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create a loading state
final themeProvider =
    StateNotifierProvider<ThemeNotifier, AsyncValue<ThemeMode>>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AsyncValue<ThemeMode>> {
  ThemeNotifier() : super(const AsyncValue.loading()) {
    _loadTheme();
  }

  static const _key = 'theme_mode';

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_key) ?? 0;
      state = AsyncValue.data(ThemeMode.values[themeIndex]);
    } catch (e) {
      state = AsyncValue.data(ThemeMode.system); // Fallback to system theme
    }
  }

  Future<void> setTheme(ThemeMode theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_key, theme.index);
      state = AsyncValue.data(theme);
    } catch (e) {
      // Handle error
    }
  }
}
