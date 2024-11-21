import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/screens/confirm_booking/booking_confirmation_screen.dart';
import 'package:ionicons/ionicons.dart';

import '../../../config/app_config.dart';
import '../../../controllers/booking/booking_controller.dart';
import '../../../models/tee_time/tee_time_model.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_step_indicator.dart';
import '../../../widgets/custom_step_tile_name.dart';

class TeeTimeSlotsScreen extends StatelessWidget {
  final TeeTimeModel teeTimeModel;
  final String weekEndRestriction;
  final String fridayRestriction;

  const TeeTimeSlotsScreen({
    super.key,
    required this.teeTimeModel,
    required this.weekEndRestriction,
    required this.fridayRestriction,
  });

  @override
  Widget build(BuildContext context) {
    final bookingsController = Get.find<BookingsController>();

    final filteredTeeTimes = bookingsController.filterTeeTimes(
      teeTimes: teeTimeModel.timeSlots.map((slot) => slot.time).toList(),
      weekEndRestriction: weekEndRestriction,
      fridayRestriction: fridayRestriction,
    );

    return Scaffold(
      appBar: AppBar(
        leading: const Hero(tag: 'bookTeeTime', child: CustomBackButton()),
      ),
      body: Padding(
        padding: AppConfig.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StepIndicator(currentStep: 2, totalSteps: 3),
            const SizedBox(height: 10),
            const StepTitle(title: "Step 2: Choose a tee time slot"),
            const SizedBox(height: 10),
            Text(
              "Please choose a time slot for your booking.",
              style: TextStyle(
                  fontSize: AppConfig.bodyFontSize,
                  color: Theme.of(context).colorScheme.primary.withOpacity(.5)),
            ),
            const SizedBox(height: 20),
            if (filteredTeeTimes.isEmpty)
              const Center(
                child: Text(
                  'No available tee times.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )
            else
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth < 370 ? 3 : 4;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: filteredTeeTimes.length,
                      itemBuilder: (context, index) {
                        final timeSlot = filteredTeeTimes[index];
                        return Obx(() {
                          final isSelected =
                              bookingsController.selectedTeeTime.value ==
                                  timeSlot;

                          return GestureDetector(
                            onTap: () {
                              bookingsController.selectedTeeTime.value =
                                  timeSlot;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppConfig.borderRadius),
                                color: isSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(.6)
                                    : Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.05),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Ionicons.time_outline,
                                      size: AppConfig.smallIconSize,
                                      color: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      timeSlot,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                        fontSize: AppConfig.smallBodyFontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (bookingsController.selectedTeeTime.value.isEmpty) {
          return const SizedBox();
        }
        return Padding(
          padding: AppConfig.screenPaddingExceptTop,
          child: CustomButton(
            onPressed: () {
              Get.to(() => const BookingConfirmationScreen(),
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
