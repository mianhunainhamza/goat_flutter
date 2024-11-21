import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/screens/golf_course/golf_course_screen.dart';
import 'package:goat_flutter/screens/home/home.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import '../../../config/app_config.dart';
import '../../../controllers/booking/booking_controller.dart';
import '../../../controllers/user/user_controller.dart';
import '../../../widgets/custom_back_button.dart';
import '../../widgets/custom_step_indicator.dart';
import '../../widgets/custom_step_tile_name.dart';
import 'components/build_detail_item.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingsController = Get.find<BookingsController>();
    final userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        leading: const Hero(
          tag: 'bookingConfirmation',
          child: CustomBackButton(),
        ),
      ),
      body: Padding(
        padding: AppConfig.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StepIndicator(currentStep: 3, totalSteps: 3),
            const SizedBox(height: 10),
            const StepTitle(title: "Step 3: Confirm your booking"),
            const SizedBox(height: 20),
            Text(
              "🎉 Almost There!",
              style: TextStyle(
                fontSize: AppConfig.subheadingFontSize,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Review your booking details below.",
              style: TextStyle(
                fontSize: AppConfig.bodyFontSize,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 2,
              color: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConfig.borderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    buildDetailItem(
                      context,
                      label: "User Name",
                      value: userController.userModel.value?.name ?? "Guest",
                      icon: Icons.person_outline,
                    ),
                    const Divider(height: 30, thickness: 1),
                    buildDetailItem(
                      context,
                      label: "Golf Course",
                      value: bookingsController
                              .selectedGolfCourseModel.value?.courseName ??
                          "Unknown",
                      icon: Icons.golf_course_outlined,
                    ),
                    const Divider(height: 30, thickness: 1),
                    buildDetailItem(
                      context,
                      label: "Tee Name",
                      value: bookingsController.selectedTee.value,
                      icon: Icons.flag_outlined,
                    ),
                    const Divider(height: 30, thickness: 1),
                    buildDetailItem(
                      context,
                      label: "Tee Time Slot",
                      value: bookingsController.selectedTeeTime.value,
                      icon: Icons.access_time_outlined,
                    ),
                    const Divider(height: 30, thickness: 1),
                    buildDetailItem(
                      context,
                      label: "Booking Date",
                      value: bookingsController.bookingDate.value,
                      icon: Icons.calendar_today_outlined,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Obx(() => Align(
                  alignment: Alignment.center,
                  child: SwipeableButtonView(
                    buttonText: bookingsController.isConfirmationLoading.value
                        ? "Processing..."
                        : "SWIPE TO CONFIRM",
                    buttontextstyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    buttonColor: bookingsController.isConfirmationLoading.value
                        ? const Color(0xFFB0B0B0)
                        : Theme.of(context).colorScheme.secondary,
                    buttonWidget: bookingsController.isConfirmationLoading.value
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary),
                          )
                        : Icon(
                            Ionicons.arrow_forward,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    isFinished: bookingsController.isConfirmationLoading.value,
                    onWaitingProcess: () async {
                      if (bookingsController.isConfirmationLoading.value) {
                        return;
                      }
                      bookingsController.isConfirmationLoading.value = true;
                      // Call the function to handle booking
                      final isSuccessful = await bookingsController.addBooking(
                        golfCourseNo: bookingsController
                                .selectedGolfCourseModel.value?.orderBy
                                .toString() ??
                            "Unknown",
                        teeTimeName: bookingsController.selectedTee.value,
                        timeSlot: bookingsController.selectedTeeTime.value,
                        context: context,
                        bookingDate: bookingsController.bookingDate.value,
                        teeTimeId: '',
                      );

                      if (isSuccessful) {
                        Get.offAll(const HomeScreen(),
                            transition: Transition.cupertino);
                      }

                      bookingsController.isConfirmationLoading.value = false;
                    },
                    onFinish: () {
                      bookingsController.isConfirmationLoading.value = false;
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
