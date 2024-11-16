import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';  // Import Firebase Realtime Database
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:goat_flutter/screens/home.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../user/user_controller.dart';

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

  // Login function
  Future<void> loginUser(BuildContext context) async {
    if (isLoggingIn.value) return;
    isLoggingIn.value = true;

    try {
      final email = emailController.text.trim();
      final password = passController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        CustomSnackbar.showSnackBar(
          'Error',
          'Email and Password are required',
          const Icon(Icons.error),
          context,
        );
        isLoggingIn.value = false;
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user?.uid;

      if (userId != null) {
        final userController = Get.put(UserController());

        String? token = await userCredential.user?.getIdToken();

        if (token != null) {
          final databaseRef = FirebaseDatabase.instance.ref();
          await databaseRef.child('users').child(userId).update({
            'token': token,
          });

          print("Token stored successfully: $token");
        }

        await userController.fetchUserData(userId);

        emailController.clear();
        passController.clear();

        CustomSnackbar.showSnackBar(
          'Success',
          'Logged in successfully',
          const Icon(Icons.check_circle),
          context,
        );

        Get.to(() => const HomeScreen());
      }
    } catch (e) {
      print(e);
      String errorMessage = 'An error occurred';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found with this email';
            break;
          case 'wrong-password':
            errorMessage = 'Incorrect password';
            break;
          default:
            errorMessage = 'Error: ${e.message}';
        }
      }

      CustomSnackbar.showSnackBar(
        'Error',
        errorMessage,
        const Icon(Icons.error),
        context,
      );
    } finally {
      isLoggingIn.value = false;
    }
  }
}
