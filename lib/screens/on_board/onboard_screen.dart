import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/screens/auth/auth_selection/auth_selection.dart';
import '../../widgets/custom_button.dart';
import 'components/on_boarding_card.dart';
import 'components/on_boarding_data.dart';
import '../../config/app_config.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnboardScreen> {
  final PageController _pageController1 = PageController(initialPage: 0);
  final PageController _pageController2 = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConfig.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppConfig.spaceBetween),
            Container(
              height: 10,
              width: 10,
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 7,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: onBoardinglist.length,
                physics: const BouncingScrollPhysics(),
                controller: _pageController1,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnBoardingCard(
                    onBoardingModel: onBoardinglist[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 37),
            Expanded(
              flex: 3,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: onBoardinglist.length,
                physics: const BouncingScrollPhysics(),
                controller: _pageController2,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingTextCard(
                    onBoardingModel: onBoardinglist[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: () {
                if (_currentIndex == onBoardinglist.length - 1) {
                  Get.to(() => const AuthSelectionScreen(),transition: Transition.cupertino);
                } else {
                  _pageController1.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                  _pageController2.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              text: _currentIndex == onBoardinglist.length - 1
                  ? 'Get Started'
                  : 'Next',
              isLoading: false,
              tag: 'onboard',
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
