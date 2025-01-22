enum Enviroment { dev, prod }

class AppConfig {
  static const Enviroment enviroment = Enviroment.dev;

  static const String supabaseUrl = '';
  static const String supabaseAnonKey = '';

  static const redirectUrlWeb =
      'https://supabase-flutter-boilerplate.nickfriedrich.de';
  static const redirectUrlMobile =
      'de.nickfriedrich.supabase-flutter-boilerplate://';
}
