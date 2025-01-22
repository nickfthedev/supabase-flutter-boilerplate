import 'package:flutter/material.dart';
import 'package:supabase_flutter_boilerplate/shared/providers/theme_provider.dart';
import 'package:supabase_flutter_boilerplate/shared/router/router.dart';
import 'package:supabase_flutter_boilerplate/shared/theme/dark_mode.dart';
import 'package:supabase_flutter_boilerplate/shared/theme/light_mode.dart';
import 'package:supabase_flutter_boilerplate/features/home/home_page.dart';
import 'package:supabase_flutter_boilerplate/features/profile/profile_page.dart';
import 'package:supabase_flutter_boilerplate/shared/config/supabase_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter_boilerplate/features/auth/widgets/auth_guard.dart';
import 'package:supabase_flutter_boilerplate/features/auth/auth_provider.dart';

// TODO: Error message on invalid password recovery link

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig().initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = ref.read(authProvider.notifier).navigatorKey;

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Habigotchi',
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ref.watch(themeProvider).when(
            loading: () => ThemeMode.system,
            error: (_, __) => ThemeMode.system,
            data: (theme) => theme,
          ),
      initialRoute: '/',
      routes: AppRouter.routes,
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({this.initialIndex = 0, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const AuthGuard(child: ProfileScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
