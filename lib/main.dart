import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/screens/on_board/onboard_screen.dart';
import 'package:goat_flutter/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/app_theme.dart';
import 'controllers/user/user_controller.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      themeMode: ThemeMode.light,
      initialBinding: InitialBinding(),
      home: isLoggedIn ? const HomeScreen() : const OnboardScreen(),
      // home: const UserTypeView(),
    );
  }
}
