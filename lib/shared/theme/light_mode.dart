import 'package:flutter/material.dart';

/*
 * Light Mode Theme
 * 
 */

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.deepPurple,
    onPrimary: Colors.white,
    secondary: Colors.deepPurpleAccent,
    onSecondary: Colors.white,
    tertiary: Colors.grey[400]!,
    onTertiary: Colors.white,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
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