import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user/user_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              userController.signOut(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        final user = userController.userModel.value;
        if (user == null) {
          return const Center(child: Text('No user data found.'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: user.profileImage.isNotEmpty
                    ? NetworkImage(user.profileImage)
                    : const NetworkImage('https://www.example.com/default-profile-image.png'), // Default image if no profile image
              ),
              const SizedBox(height: 16),
              Text(
                'Name: ${user.name}',
              ),
              Text(
                'Email: ${user.email}',
              ),
              Text(
                'Phone: ${user.phone}',  // Display phone
              ),
              Text(
                'Address: ${user.address}',  // Display address
              ),
              Text(
                'Role: ${user.token}',  // Display role
              ),Text(
                'Role: ${user.role}',  // Display role
              ),Text(
                'Role: ${user.role}',  // Display role
              ),Text(
                'Role: ${user.role}',  // Display role
              ),Text(
                'Role: ${user.role}',  // Display role
              ),
            ],
          ),
        );
      }),
    );
  }
}
