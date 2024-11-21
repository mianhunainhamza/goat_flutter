import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:goat_flutter/controllers/booking/booking_controller.dart';
import 'package:goat_flutter/screens/see_booking/see_booking_screen.dart';
import '../../controllers/golf_course/golf_course_controller.dart';
import '../../widgets/custom_button.dart';
import '../../config/app_config.dart';
import '../../widgets/custom_back_button.dart';
import '../show_tee_times/show_tee_times_screen.dart';
import 'components/build_golf_course_shimmer.dart';

class GolfCourseScreen extends StatelessWidget {
  const GolfCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GolfCourseController golfCourseController =
        Get.put(GolfCourseController());
    final BookingsController bookingsController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const Hero(tag: 'bookTeeTime', child: CustomBackButton()),
      ),
      body: Obx(() {
        if (golfCourseController.isLoading.value) {
          return buildGolfCourseShimmer();
        }

        if (golfCourseController.golfCourses.isEmpty) {
          return const Center(child: Text("No golf courses available."));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: golfCourseController.golfCourses.length,
            itemBuilder: (context, index) {
              final course = golfCourseController.golfCourses[index];

              return (course.courseName.isNotEmpty)
                  ? FutureBuilder<bool>(
                      future: bookingsController.isSportFullyBooked(
                        course.orderBy.toString(),
                        bookingsController.bookingDate.value,
                        course.spotsAllowed,
                      ),
                      builder: (context, snapshot) {
                        bool isFullyBooked = snapshot.data ?? false;

                        return Card(
                          color: Theme.of(context).colorScheme.secondary,
                          elevation: 4,
                          shadowColor: Colors.black.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: course.image,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.broken_image,
                                          size: 80,
                                          color: Colors.grey,
                                        ),
                                        placeholder: (context, url) =>
                                            const SizedBox(),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        course.courseName,
                                        style: const TextStyle(
                                            fontSize:
                                                AppConfig.subheadingFontSize,
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic),
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Divider(color: Colors.grey.shade400),
                                const SizedBox(height: 10),
                                CustomButton(
                                  height: 40,
                                  textHeight: 14,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .tertiary
                                      .withOpacity(.8),
                                  text: isFullyBooked
                                      ? 'Fully Booked'
                                      : 'Book Now',
                                  onPressed: isFullyBooked
                                      ? () {}
                                      : () {
                                          Get.to(
                                              () => TeeTimesScreen(
                                                    golfCourseModel: course,
                                                  ),
                                              transition: Transition.cupertino);
                                        },
                                  isLoading: false,
                                  tag: '$index',
                                ),
                                const SizedBox(height: 15),
                                CustomButton(
                                  height: 40,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.3),
                                  text: 'See Bookings',
                                  textHeight: 14,
                                  onPressed: () {
                                    Get.to(
                                      () => SeeBookingsScreen(
                                          golfCourseId: (index + 1).toString()),
                                      transition: Transition.cupertino,
                                    );
                                  },
                                  isLoading: false,
                                  tag: '$index-see-bookings',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container();
            },
          ),
        );
      }),
    );
  }
}
