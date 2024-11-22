import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/controllers/golf_course/golf_course_controller.dart';
import 'package:goat_flutter/models/golf_course/golf_course_model.dart';
import 'package:goat_flutter/screens/course_tee_sheet/course_tee_sheet_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/custom_button.dart';
import '../../../config/app_config.dart';
import '../../show_tee_times/show_tee_times_screen.dart';

void showBookingConfirmationDialog({
  required BuildContext context,
  required GolfCourseModel golfCourseModel,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final GolfCourseController golfCourseController = Get.find();
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                'Select Booking',
                style: TextStyle(
                  fontSize: AppConfig.subheadingFontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),

              // Message
              Text(
                'Please call the golf course before booking to get the accurate information first.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppConfig.bodyFontSize,
                  color: Theme.of(context).colorScheme.primary.withOpacity(.7),
                ),
              ),
              const SizedBox(height: 24),

              // Course Tee Sheet Button
              CustomButton(
                height: 40,
                textHeight: AppConfig.bodyFontSize,
                text: 'Course Tee Sheet',
                onPressed: () {
                  Get.to(
                    () => CourseTeeSheetScreen(
                        url: golfCourseController
                            .getBookingUrl(golfCourseModel.courseName)!),
                    transition: Transition.cupertino,
                  );
                },
                isLoading: false,
                tag: 'tee-sheet',
              ),
              const SizedBox(height: 12),

              // Book On GoatApp Button
              CustomButton(
                textHeight: AppConfig.bodyFontSize,
                height: 40,
                text: 'Book On GoatApp',
                onPressed: () {
                  Get.to(() => TeeTimesScreen(golfCourseModel: golfCourseModel),
                      transition: Transition.cupertino);
                },
                isLoading: false,
                tag: 'book-goat',
              ),
              const SizedBox(height: 12),

              // Call Now to Finalize Button
              CustomButton(
                textHeight: AppConfig.bodyFontSize,
                height: 40,
                text: 'Call Now to Finalize',
                onPressed: () {
                  final Uri phoneUri = Uri(
                    scheme: 'tel',
                    path: golfCourseModel.phone,
                  );
                  launchUrl(phoneUri);
                  Navigator.of(context).pop();
                },
                isLoading: false,
                tag: 'call-now',
              ),
              const SizedBox(height: 24),

              // Cancel Button
              CustomButton(
                textHeight: AppConfig.bodyFontSize,
                height: 40,
                text: 'Cancel',
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isLoading: false,
                tag: 'cancel',
                backgroundColor: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      );
    },
  );
}
