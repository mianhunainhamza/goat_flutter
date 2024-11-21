import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/controllers/user/user_controller.dart';
import 'package:goat_flutter/screens/book_tee_time/book_tee_time_screen.dart';
import 'package:goat_flutter/screens/goat_shop/goat_shop_screen.dart';
import 'package:goat_flutter/screens/golf_course_list/golf_course_list_screen.dart';
import 'package:goat_flutter/screens/upcoming_outing/upcoming_outing_screen.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import '../../config/app_config.dart';
import 'components/build_quick_action_card.dart';
import 'components/build_book_tee_time_card.dart';
import 'components/build_stats_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            userController.logOut(context);
          },
          icon: Icon(
            Icons.golf_course,
            size: 35,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          Obx(() {
            return CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                userController.userModel.value?.profileImage ??
                    "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-File.png",
              ),
            );
          }),
          const SizedBox(width: 10),
        ],
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return Align(
            alignment: Alignment.center,
            child: SizedBox(
                width: Get.width,
                child: Lottie.asset('assets/lottie/loading.json')),
          );
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: AppConfig.screenPadding,
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: MediaQuery.of(context).size.width / 2,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  Obx(() {
                    if (userController.userModel.value != null) {
                      return TweenAnimationBuilder(
                        duration: const Duration(seconds: 1),
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        builder: (context, double opacity, child) {
                          return Opacity(
                            opacity: opacity,
                            child: Text(
                              'Hi ${userController.userModel.value!.name}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: AppConfig.headingFontSize + 1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  const Text(
                    "Explore GOAT now",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: AppConfig.smallBodyFontSize,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: AppConfig.spaceBetween),
                  const BookTeeTimeCard(
                    tag: 'bookTeeTime',
                    targetScreen: BookTeeTimeScreen(),
                  ),
                  const SizedBox(height: AppConfig.spaceBetween * 3),
                  // Quick Actions Section
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: AppConfig.subheadingFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConfig.spaceBetween * 2),
                  const QuickActionTiles(),
                  const SizedBox(height: AppConfig.spaceBetween),
                  Text(
                    "Stats",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: AppConfig.subheadingFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConfig.spaceBetween),
                  const StatsTiles()
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

// FunctionTileData Model
class FunctionTileData {
  final IconData? icon;
  final String? imagePath;
  final String name;
  final String? email;
  final Widget? targetPage;

  FunctionTileData({
    this.icon,
    required this.name,
    this.targetPage,
    this.imagePath,
    this.email,
  });
}

final List<FunctionTileData> functionTileData = [
  FunctionTileData(
      icon: Ionicons.list_sharp,
      name: "Golf Course List",
      targetPage: const GolfCourseListScreen()),
  FunctionTileData(
      imagePath: 'assets/images/goat_stroke.png',
      name: "Goat Shop",
      targetPage: const GoatShopScreen(url: 'https://shop.golfonanytee.com/')),
  FunctionTileData(
      icon: Ionicons.calendar,
      name: "Upcoming Outing",
      targetPage:
          const UpcomingOutingScreen(url: 'https://golfonanytee.com/outings/')),
  FunctionTileData(
      icon: Ionicons.call,
      name: "Contact Support",
      email: 'info@golfonanytee.com'),
];

class TaskProgress {
  final String title;
  final double status;

  TaskProgress({required this.title, required this.status});
}

final List<TaskProgress> taskProgressList = [
  TaskProgress(title: 'Ongoing', status: 15),
  TaskProgress(title: 'Upcoming', status: 5),
];
