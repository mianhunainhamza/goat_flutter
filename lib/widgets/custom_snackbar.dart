import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSnackBar(String title, String message, Widget icon,
      BuildContext context) {
    Get.showSnackbar(
      GetSnackBar(
        borderRadius: 20,
        backgroundColor: Colors.transparent,
        messageText: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Theme.of(context).colorScheme.secondary.withOpacity(.7),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        message,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isDismissible: true,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        padding: EdgeInsets.zero,
        // Remove default padding
        snackStyle: SnackStyle.GROUNDED,
        barBlur: 20,
      ),
    );
  }
}
