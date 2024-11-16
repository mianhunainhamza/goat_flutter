import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/config/app_config.dart';
import 'package:goat_flutter/controllers/auth/sign_up/sign_up_controller.dart';
import 'package:goat_flutter/widgets/custom_back_button.dart';
import 'package:ionicons/ionicons.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());

    return Scaffold(
      appBar: AppBar(
        leading: const Hero(tag: 'first', child: CustomBackButton()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppConfig.screenPadding,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.camera_alt,
                          size: 35, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: controller.nameController,
                  labelText: 'Full Name',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Ionicons.person),
                  keyboardType: TextInputType.name,
                ),
                CustomTextField(
                  controller: controller.phoneController,
                  labelText: 'Phone',
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Ionicons.call),
                ),
                CustomTextField(
                  controller: controller.emailController,
                  labelText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.emailValidator,
                  prefixIcon: const Icon(Icons.email),
                ),
                CustomTextField(
                  controller: controller.addressController,
                  labelText: 'Mailing Address',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mailing address';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Ionicons.location),
                  keyboardType: TextInputType.text,
                ),
                Obx(() => CustomTextField(
                      controller: controller.passController,
                      labelText: 'Password',
                      obscureText: controller.obscureText.value,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      prefixIcon: const Icon(Ionicons.lock_closed),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    )),
                Obx(() => CustomTextField(
                      controller: controller.confirmPassController,
                      labelText: 'Confirm Password',
                      obscureText: controller.obscureText.value,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != controller.passController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      prefixIcon: const Icon(Ionicons.lock_closed),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    )),
                const SizedBox(height: 20),
                Obx(() => CustomButton(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      text: "SIGN UP",
                      isLoading: controller.isLoading.value,
                      onPressed: () async {
                        if (!controller.isLoading.value) {
                          controller.signUp(context);
                        }
                      },
                      tag: 'signup',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
