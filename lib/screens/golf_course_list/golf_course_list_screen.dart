import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:goat_flutter/screens/golf_course/components/build_golf_course_shimmer.dart';
import 'package:goat_flutter/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/app_config.dart';
import '../../controllers/golf_course/golf_course_controller.dart';
import '../../models/golf_course/golf_course_model.dart';
import '../../widgets/custom_back_button.dart';

class GolfCourseListScreen extends StatelessWidget {
  const GolfCourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GolfCourseController controller = Get.put(GolfCourseController());

    return Scaffold(
      appBar: AppBar(
        leading: const Hero(tag: 'bookTeeTime', child: CustomBackButton()),
        title: const Text(
          'GOLF Courses',
          style: TextStyle(
              fontSize: AppConfig.headingFontSize, fontStyle: FontStyle.italic),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return buildGolfCourseShimmer();
        }

        if (controller.golfCourses.isEmpty) {
          return const Center(child: Text('No golf courses available.'));
        }

        return ListView.builder(
          padding: AppConfig.screenPadding,
          itemCount: controller.golfCourses.length,
          itemBuilder: (context, index) {
            final golfCourse = controller.golfCourses[index];

            if (golfCourse.image.isEmpty) {
              return const SizedBox.shrink();
            }

            return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildGolfCourseCard(golfCourse, context,index));
          },
        );
      }),
    );
  }

  Widget _buildGolfCourseCard(
      GolfCourseModel golfCourse, BuildContext context,int index) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: const BoxDecoration(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: golfCourse.image,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Container(
                      color: Colors.grey[300],
                      height: 80,
                      width: 80,
                      child:
                          const Icon(Icons.error, size: 40, color: Colors.red),
                    );
                  },
                  placeholder: (context, url) => const SizedBox(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course name with text wrapping
                    Text(
                      golfCourse.courseName,
                      style: const TextStyle(
                        fontSize: AppConfig.subheadingFontSize,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(height: 30),

                    CustomButton(
                      backgroundColor: Theme.of(context).colorScheme.tertiary.withOpacity(.8),
                        height: 40,
                        textHeight: AppConfig.smallBodyFontSize,
                        text: 'Call Now',
                        onPressed: () => _callGolfCourse(golfCourse.phone),
                        isLoading: false,
                        tag: 'tag+$index'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _callGolfCourse(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    await launchUrl(phoneUri);
  }
}
