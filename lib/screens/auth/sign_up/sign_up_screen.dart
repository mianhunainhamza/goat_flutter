import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/config/app_config.dart';
import 'package:goat_flutter/controllers/auth/sign_up/sign_up_controller.dart';
import 'package:goat_flutter/widgets/custom_back_button.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
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
      body: Padding(
        padding: AppConfig.screenPadding,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () => controller.pickImage(context),
                          child: Obx(() => CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey[200],
                            backgroundImage:
                            controller.profileImage.value != null
                                ? NetworkImage(controller.profileImage.value!)
                                : null,
                            child: controller.profileImage.value == null
                                ? const Icon(Icons.camera_alt,
                                size: 35, color: Colors.grey)
                                : null,
                          )),
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
                        prefixIcon: const Icon(Icons.person),
                        keyboardType: TextInputType.name,
                      ),
                      CustomTextField(
                        controller: controller.phoneController,
                        labelText: 'Phone',
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.phone),
                        keyboardType: TextInputType.phone,
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
                        prefixIcon: const Icon(Icons.location_on), keyboardType: TextInputType.emailAddress,
                      ),
                      Obx(() => CustomDropdownField(
                        labelText: 'Time Zone',
                        value: controller.selectedTimeZone.value,
                        items: controller.timeZones,
                        onChanged: controller.selectTimeZone,
                      )),
                      Obx(() => CustomTextField(
                        controller: controller.passController,
                        labelText: 'Password',
                        obscureText: controller.obscureText.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ), keyboardType: TextInputType.visiblePassword,
                      )),
                      Obx(() => CustomTextField(
                        controller: controller.confirmPassController,
                        labelText: 'Confirm Password',
                        obscureText: controller.obscureText.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != controller.passController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ), keyboardType: TextInputType.visiblePassword,
                      )),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() => CustomButton(
              text: "SIGN UP",
              isLoading: controller.isLoading.value,
              onPressed: () async {
                if (!controller.isLoading.value) {
                  controller.signUp(context);
                }
              }, tag: 'signup',
            )),
          ],
        ),
      ),
    );
  }
}
