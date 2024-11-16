import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/custom_snackbar.dart'; // Assuming the custom snackbar is located here

class SignupController extends GetxController {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

  var obscureText = true.obs;
  var isLoading = false.obs;
  var profileImage = Rx<String?>(null);
  var isAgree = false.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    final validDomains = ["gmail.com", "icloud.com", "yahoo.com"];
    if (!validDomains.any((domain) => value.endsWith(domain))) {
      return 'Please use a valid email address';
    }
    return null;
  }

  // Method to handle sign-up logic
  Future<void> signUp(BuildContext context) async {
    if (isLoading.value) return;
    isLoading.value = true;

    // Basic validation before proceeding
    if (nameController.text.isEmpty || phoneController.text.isEmpty || emailController.text.isEmpty || addressController.text.isEmpty) {
      CustomSnackbar.showSnackBar(
        'Error',
        'Please fill all the fields correctly',
        const Icon(Icons.warning_amber),
        context,
      );
      isLoading.value = false;
      return;
    }

    if (!isAgree.value) {
      CustomSnackbar.showSnackBar(
        'Error',
        'Please agree to terms and conditions',
        const Icon(Icons.warning_amber),
        context,
      );
      isLoading.value = false;
      return;
    }

    if (passController.text != confirmPassController.text) {
      CustomSnackbar.showSnackBar(
        'Error',
        'Passwords do not match',
        const Icon(Icons.warning_amber),
        context,
      );
      isLoading.value = false;
      return;
    }

    try {
      final email = emailController.text;
      final password = passController.text;

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection("users").doc(userCredential.user?.uid).set({
        'name': nameController.text,
        'phone': phoneController.text,
        'email': email,
        'address': addressController.text,
        'profileImage': profileImage.value,
      });

      CustomSnackbar.showSnackBar(
        'Success',
        'Account created successfully',
        const Icon(Icons.check_circle),
        context,
      );

      isLoading.value = false;
    } catch (e) {
      CustomSnackbar.showSnackBar(
        'Error',
        e.toString(),
        const Icon(Icons.error),
        context,
      );
      isLoading.value = false;
    }
  }
}
