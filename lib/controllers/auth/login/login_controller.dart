import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  var isLoggingIn = false.obs;
  var obscureText = true.obs;

  // Validator for the email
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Invalid email address';
    }
    return null;
  }

  // Validator for the password
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Toggle visibility of password
  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  // Login function (simulated here, replace with real login logic)
  void loginUser() async {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
      isLoggingIn.value = true;
      await Future.delayed(const Duration(seconds: 2)); // Simulate loading
      isLoggingIn.value = false;
      // Add authentication logic here (e.g., Firebase Authentication)
      // For now, just print the login info
      print('Logging in with email: ${emailController.text}');
      // On success, navigate to the next screen or handle login error
    }
  }
}
