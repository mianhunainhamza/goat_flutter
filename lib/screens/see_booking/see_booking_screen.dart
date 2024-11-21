import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/screens/golf_course/components/build_golf_course_shimmer.dart';
import 'package:goat_flutter/widgets/custom_back_button.dart';
import '../../controllers/booking/booking_controller.dart';
import '../../models/booking/booking_model.dart';
import 'components/build_booking_details_card.dart';

class SeeBookingsScreen extends StatelessWidget {
  final String golfCourseId;

  const SeeBookingsScreen({
    required this.golfCourseId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BookingsController controller = Get.put(BookingsController());
    controller.fetchBookings(golfCourseId);

    return Scaffold(
      appBar: AppBar(
        leading: const Hero(
            tag: 'bookTeeTime',
            child: CustomBackButton()),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return buildGolfCourseShimmer();
        }

        if (controller.bookings.isEmpty) {
          return const Center(child: Text("No bookings found."));
        }

        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            final BookingModel booking = controller.bookings[index];
            return buildBookingCard(booking, context);
          },
        );
      }),
    );
  }
}
