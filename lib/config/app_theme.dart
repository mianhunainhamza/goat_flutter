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
    //primary is for texts, and stuff like that
    primary: Colors.black,
    //secondary is for areas where it will not be used as a background
    secondary: Colors.white,
    //its specific for buttons colors
    tertiary: Colors.green.withOpacity(.7),
    //its for the Auth Selection screen background (For now only using there)
    onPrimary: const Color(0xFF008854),
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
