import 'package:flutter/material.dart';

class ThemeConfig {
  // Dark theme color scheme
  static ColorScheme darkColorScheme = ColorScheme.fromSeed(
    primary: Colors.white,
    secondary: Colors.black,
    onPrimary: Colors.white,
    surface: Colors.black87,
    onSurface: Colors.white,
    onSecondary: Colors.white,
    seedColor: Colors.black,
  );

  // Light theme color scheme
  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
    primary: Colors.black,
    secondary: Colors.white,
    onPrimary: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    onSecondary: Colors.black,
    seedColor: Colors.blue,
  );


  static ThemeData darkTheme = ThemeData(
    colorScheme: darkColorScheme,
    useMaterial3: true,
    fontFamily: 'Lora',
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

  );


  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    fontFamily: 'Lora',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );
}
