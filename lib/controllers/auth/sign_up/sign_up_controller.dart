import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../models/user/user_model.dart';
import '../../../widgets/custom_snackbar.dart';

class SignupController extends GetxController {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

  var obscureText = true.obs;
  final RxString selectedTimeZone = 'Chicago UTC-06:00'.obs;
  var isLoading = false.obs;
  var profileImage = Rx<String?>(null);
  final ImagePicker _imagePicker = ImagePicker();
  var uploadingImage = false.obs;

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

  final List<String> timeZones = [
    'Chicago UTC-06:00',
    'Atlanta UTC-05:00',
  ];

  void selectTimeZone(String? value) {
    if (value != null) {
      selectedTimeZone.value = value;
    }
  }

  void clearFields() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    passController.clear();
    confirmPassController.clear();
    profileImage.value = null;
  }

  Future<void> pickImage(BuildContext context) async {
    // Check for gallery permission
    if (await Permission.photos.isDenied ||
        await Permission.photos.isPermanentlyDenied) {
      if (await Permission.photos.request().isDenied) {
        CustomSnackbar.showSnackBar(
          'Permission Required',
          'Gallery access is needed to upload a profile picture',
          const Icon(Icons.warning_amber),
          context,
        );
        return;
      }
    }

    try {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);
        CustomSnackbar.showSnackBar(
          'Uploading',
          'Uploading your profile picture...',
          const Icon(Icons.upload),
          context,
        );

        String fileName =
            "profileImages/${DateTime.now().millisecondsSinceEpoch}.jpg";
        UploadTask uploadTask =
            FirebaseStorage.instance.ref(fileName).putFile(file);

        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        profileImage.value = downloadUrl;

        CustomSnackbar.showSnackBar(
          'Success',
          'Profile picture uploaded successfully!',
          const Icon(Icons.check_circle),
          context,
        );
      }
    } catch (e) {
      CustomSnackbar.showSnackBar(
        'Error',
        'Failed to pick or upload image: ${e.toString()}',
        const Icon(Icons.error),
        context,
      );
    }
  }

  Future<void> signUp(BuildContext context) async {
    if (isLoading.value || uploadingImage.value) return;

    if (profileImage.value == null) {
      CustomSnackbar.showSnackBar(
        'Error',
        'Please upload a profile picture',
        const Icon(Icons.warning_amber),
        context,
      );
      return;
    }
    if (!uploadingImage.value) {
      CustomSnackbar.showSnackBar(
        'Error',
        'Wait while uploading image',
        const Icon(Icons.warning_amber),
        context,
      );
      return;
    }

    isLoading.value = true;

    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty) {
      CustomSnackbar.showSnackBar(
        'Error',
        'Please fill all the fields correctly',
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

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(userCredential.user?.uid ?? '');

      final userModel = UserModel(
        userId: FirebaseAuth.instance.currentUser?.uid ?? '',
        email: email,
        name: nameController.text,
        role: 'user',
        profileImage: profileImage.value!,
        token: '',
        enabled: 1,
        address: addressController.text,
        phone: phoneController.text,
        timeZone: selectedTimeZone.value,
      );

      await userRef.set(userModel.toMap());

      CustomSnackbar.showSnackBar(
        'Success',
        'Account created successfully',
        const Icon(Icons.check_circle),
        context,
      );

      clearFields();
      isLoading.value = false;
    } catch (e) {
      String errorMessage = 'An error occurred';

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'Email already exists';
            break;
          case 'weak-password':
            errorMessage = 'Password is too weak';
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
      isLoading.value = false;
    }
  }
}
