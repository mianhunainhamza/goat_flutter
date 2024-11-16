import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.green,
          secondary: Colors.green,
          onPrimary: Colors.black,
          surface: Colors.white.withOpacity(.9),
          onSecondary: Colors.white, seedColor: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Lora',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const OnBoardingScreen(),
    );
  }
}

