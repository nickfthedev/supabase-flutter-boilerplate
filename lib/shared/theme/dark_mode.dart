import 'package:flutter/material.dart';

/*
 * Light Mode Theme
 * 
 */

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: Colors.deepPurple,
    onPrimary: Colors.white,
    secondary: Colors.deepPurpleAccent,
    onSecondary: Colors.white,
    tertiary: Colors.grey[800]!,
    onTertiary: Colors.white,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
);


// ThemeData lightMode = ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           surface: Colors.white,
//           seedColor: Colors.deepPurple,
//           primary: Colors.deepPurple,
//           onPrimary: Colors.white,
//           secondary: Colors.deepPurpleAccent,
//           onSecondary: Colors.white,
//           tertiary: Colors.grey,
//           onTertiary: Colors.white,
//         ),
//         useMaterial3: true,
// );