import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserType { teacher, student }

class UserTypeCard extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isSelected;
  final String image;

  const UserTypeCard({
    required this.onTap,
    required this.isSelected,
    required this.text,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedButton(
        onTap: onTap,
        child: Container(
          width: 160,
          height: 270,
          padding: const EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? AppColors.kPrimary : AppColors.kWhite,
            boxShadow: [AppColors.defaultShadow],
          ),
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.kWhite : AppColors.kSecondary,
                ),
              ),
              const Spacer(),
              Image.asset(image),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserTypeView extends StatefulWidget {
  final void Function(UserType)? onUserTypeSelected;

  const UserTypeView({super.key, this.onUserTypeSelected});

  @override
  State<UserTypeView> createState() => _UserTypeViewState();
}

class _UserTypeViewState extends State<UserTypeView> {
  UserType userType = UserType.teacher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 50),
            FadeInLeft(
              duration: const Duration(milliseconds: 1000),
              child: const Text(
                'Join Learn Eden as a…',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kSecondary),
              ),
            ),
            const SizedBox(height: 10),
            FadeInLeft(
              duration: const Duration(milliseconds: 1000),
              child: const Text(
                'Create and sell courses as a teacher or browse courses and learn as a student.',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.kSecondary),
              ),
            ),
            const SizedBox(height: 40),
            FadeInRight(
              duration: const Duration(milliseconds: 1000),
              child: SizedBox(
                height: 320,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: UserTypeCard(
                        onTap: () {
                          setState(() {
                            userType = UserType.teacher;
                          });
                          widget.onUserTypeSelected?.call(userType);
                        },
                        isSelected: userType == UserType.teacher,
                        image: 'assets/images/golf.png',
                        text: UserType.teacher.name.capitalizeFirst.toString(),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: UserTypeCard(
                        onTap: () {
                          setState(() {
                            userType = UserType.student;
                          });
                          widget.onUserTypeSelected?.call(userType);
                        },
                        isSelected: userType == UserType.student,
                        image: 'assets/images/golf.png',
                        text: UserType.student.name.capitalizeFirst.toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const AnimatedButton({required this.child, required this.onTap, super.key});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

class AppColors {
  static const Color kPrimary = Color(0xFF329494);
  static const Color kAccent1 = Color(0xFFFCCBB9);
  static const Color kAccent2 = Color(0xFFB9C2FC);
  static const Color kAccent3 = Color(0xFFEEB8D8);
  static const Color kAccent4 = Color(0xFF6AC6C5);
  static const Color kSecondary = Color(0xFF1D2445);
  static const Color kSuccess = Color(0xFF329447);
  static const Color kGrey = Color(0xff0000004d);
  static const Color kLine = Color(0xff1d244533);
  static const Color kWhite = Color(0xFFFFFFFF);
  static const Color kLightPink = Color(0xFFF5D3BB);
  static const Color kLightPink2 = Color(0xFFFFE2CD);
  static const Color kLightBrown = Color(0xFF73665C);

  static BoxShadow defaultShadow = BoxShadow(
    color: AppColors.kPrimary.withOpacity(0.2),
    blurRadius: 7,
    offset: const Offset(0, 5),
  );

  static BoxShadow darkShadow = BoxShadow(
    color: AppColors.kSecondary.withOpacity(0.2),
    blurRadius: 7,
    offset: const Offset(0, 5),
  );
}
