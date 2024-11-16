import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/screens/auth/sign_up/sign_up_screen.dart';
import 'package:goat_flutter/widgets/custom_back_button.dart';
import '../../../widgets/custom_button.dart';
import '../login/login_screen.dart';
import 'components/ball_animation.dart';

class AuthSelectionScreen extends StatefulWidget {
  const AuthSelectionScreen({super.key});

  @override
  State<AuthSelectionScreen> createState() => _AuthSelectionScreenState();
}

class _AuthSelectionScreenState extends State<AuthSelectionScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Hero(
            tag: 'first',
            child: CustomBackButton()),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            const BallAnimation(ballSize: 50.0),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * .2),
                SizedBox(
                  width: Get.width * .6,
                  child: Image.asset(
                    'assets/images/goat-logo-detailed.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const Spacer(),
                CustomButton(
                  onPressed: () {
                    Get.to(() => const LogInScreen(),transition: Transition.cupertino);
                  },
                  text: 'L O G I N',
                  isLoading: isLoading,
                  icon: null,
                  tag: 'onboard',
                ),
                const SizedBox(height: 30),
                CustomButton(
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    Get.to(() => const SignUpScreen(),transition: Transition.cupertino);
                  },
                  text: 'Create Account',
                  isLoading: false,
                  icon: null,
                  tag: 'signup',
                ),
                SizedBox(height: Get.height * .1)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
