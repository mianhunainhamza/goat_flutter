import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/config/app_config.dart';
import 'package:goat_flutter/controllers/booking/booking_controller.dart';
import 'package:goat_flutter/models/golf_course/golf_course_model.dart';
import 'package:goat_flutter/screens/show_tee_times/components/build_tee_time_name_card.dart';
import 'package:goat_flutter/screens/show_tee_times/components/tee_time_slots_screen.dart';
import 'package:goat_flutter/widgets/custom_back_button.dart';
import 'package:goat_flutter/widgets/custom_button.dart';
import '../../widgets/custom_step_indicator.dart';
import '../../widgets/custom_step_tile_name.dart';
import 'package:animate_do/animate_do.dart';

class TeeTimesScreen extends StatelessWidget {
  final GolfCourseModel golfCourseModel;

  const TeeTimesScreen({
    super.key,
    required this.golfCourseModel,
  });

  @override
  Widget build(BuildContext context) {
    final BookingsController bookingsController = Get.find();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingsController.resetBookingData();
    });

    return Scaffold(
      appBar: AppBar(
        leading: const Hero(tag: 'bookTeeTime', child: CustomBackButton()),
      ),
      body: Padding(
        padding: AppConfig.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StepIndicator(currentStep: 1, totalSteps: 3),
            const SizedBox(height: 10),
            const StepTitle(title: "Step 1: Choose a tee"),
            const SizedBox(height: 10),
            Text(
              "1. You must be at the course at least 15 minutes before your tee time to avoid cancellation.",
              style: TextStyle(
                  fontSize: AppConfig.bodyFontSize,
                  color: Theme.of(context).colorScheme.primary.withOpacity(.5)),
            ),
            const SizedBox(height: 10),
            Text(
              "2. If you're unable to make it, please cancel your booking at least 24 hours in advance.",
              style: TextStyle(
                  fontSize: AppConfig.bodyFontSize,
                  color: Theme.of(context).colorScheme.primary.withOpacity(.5)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: golfCourseModel.teeTimes.length,
                itemBuilder: (context, index) {
                  final teeTime = golfCourseModel.teeTimes[index];
                  return Obx(() {
                    final isSelected =
                        bookingsController.selectedTee.value == teeTime.name;
                    return FadeInLeft(
                      duration: const Duration(milliseconds: 1000),
                      child: TeeTimeNameCard(
                        onTap: () {
                          bookingsController.selectedTeeTimeModel.value =
                              teeTime;
                          bookingsController.selectedGolfCourseModel.value =
                              golfCourseModel;
                          bookingsController.fridayRestriction.value =
                              golfCourseModel.fridayRestrictionTill;
                          bookingsController.weekEndRestriction.value =
                              golfCourseModel.weekendRestrictionTill;
                          bookingsController.selectedTee.value = teeTime.name;
                        },
                        isSelected: isSelected,
                        text: teeTime.name,
                        image: 'assets/images/golf.png',
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (bookingsController.selectedTee.value.isEmpty) {
          return const SizedBox();
        }
        return Padding(
          padding: AppConfig.screenPaddingExceptTop,
          child: CustomButton(
            onPressed: () {
              Get.to(
                  () => TeeTimeSlotsScreen(
                        teeTimeModel:
                            bookingsController.selectedTeeTimeModel.value!,
                        weekEndRestriction:
                            bookingsController.weekEndRestriction.value,
                        fridayRestriction:
                            bookingsController.fridayRestriction.value,
                      ),
                  transition: Transition.cupertino);
            },
            text: "N E X T",
            isLoading: false,
            tag: '',
          ),
        );
      }),
    );
  }
}
