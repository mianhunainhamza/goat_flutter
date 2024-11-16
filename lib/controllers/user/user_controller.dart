import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/screens/on_board/onboard_screen.dart';

import '../../models/user/user_model.dart';
import '../../widgets/custom_confirmation_dialog.dart';
import '../../widgets/custom_snackbar.dart';

class UserController extends GetxController {
  var userModel = Rxn<UserModel>();

  Future<void> signOut(BuildContext context) async {
    bool confirmed = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return CustomConfirmationDialog(
              title: 'Log Out',
              message: 'Are you sure you want to log out?',
              confirmText: 'Yes',
              cancelText: 'No',
              onConfirm: () {
                FirebaseAuth.instance.signOut();
                CustomSnackbar.showSnackBar(
                  'Success',
                  'You have been logged out successfully.',
                  const Icon(Icons.check_circle),
                  context,
                );
                Get.offAll(const OnBoardingScreen(),transition: Transition.cupertino);
              },
              onCancel: () {},
            );
          },
        ) ??
        false;
  }

  Future<void> fetchUserData(String userId) async {
    try {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users').child(userId);
      final snapshot = await userRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        userModel.value = UserModel.fromMap(data);
      } else {
        print('User not found');
        userModel.value = null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      userModel.value = null;
    }
  }
}
