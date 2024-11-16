import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/config/app_config.dart';
import 'package:goat_flutter/screens/auth/sign_up/sign_up_screen.dart';
import 'package:goat_flutter/widgets/custom_back_button.dart';
import '../../../controllers/auth/login/login_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        leading: const Hero(tag: 'first', child: CustomBackButton()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppConfig.screenPadding,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 50,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    'Please login to continue',
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Form(
                child: Column(
                  children: [
                    CustomTextField(
                      controller: loginController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: loginController.emailValidator,
                      labelText: 'Email',
                      obscureText: false,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: loginController.passController,
                      keyboardType: TextInputType.text,
                      validator: loginController.passwordValidator,
                      labelText: 'Password',
                      obscureText: loginController.obscureText.value,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginController.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: loginController.togglePasswordVisibility,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Obx(() => CustomButton(
                    text: 'L O G I N',
                    onPressed: () {
                      loginController.loginUser(context);
                    },
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    isLoading: loginController.isLoggingIn.value,
                    tag: 'onboard',
                  )),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(child: Divider()),
                    Text(
                      "   OR   ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const Flexible(child: Divider()),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Hero(
                tag: 'signup',
                child: Center(
                  child: GestureDetector(
                    onTap: () => Get.to(() => const SignUpScreen(),
                        transition: Transition.cupertino),
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
