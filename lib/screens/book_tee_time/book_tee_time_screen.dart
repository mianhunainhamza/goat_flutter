import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/config/app_config.dart';
import 'package:goat_flutter/controllers/booking/booking_controller.dart';
import 'package:goat_flutter/widgets/custom_back_button.dart';
import 'package:goat_flutter/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import '../golf_course/golf_course_screen.dart';
import 'components/build_custom_date_picker.dart';

class BookTeeTimeScreen extends StatefulWidget {
  const BookTeeTimeScreen({super.key});

  @override
  BookTeeTimeScreenState createState() => BookTeeTimeScreenState();
}

class BookTeeTimeScreenState extends State<BookTeeTimeScreen> {
  final List<String> _rules = [
    "1. Browse the available booking times at the course you'd like to book. Find an open tee time and immediately update the GOAT app.",
    "2. Call the pro shop to confirm the desired tee time. Book the tee time as a GOAT Member so the golf course pro shop can update their booking system.",
    "3. Arrive at the golf course where you've booked your tee time at least 20 minutes in advance. Check in with the pro shop using your GOAT ID and enjoy your round.",
    "4. A maximum of two tee times may be held at any given time.",
    "5. The two tee times must be at different courses.",
    "6. After completing the first tee time, you may then book a third tee time, and so on.",
    "7. There are no restrictions on weekdays at any golf course. Weekend restrictions are listed below.",
    "8. By agreeing to a tee time, you agree to GOAT's terms of service."
  ];

  @override
  Widget build(BuildContext context) {
    final BookingsController bookingsController = Get.put(BookingsController());

    return Scaffold(
      appBar: AppBar(
        leading: const Hero(tag: 'bookTeeTime', child: CustomBackButton()),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: AppConfig.screenPaddingExceptTop,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Booking Rules",
                style: TextStyle(
                  fontSize: AppConfig.headingFontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              ..._rules.map((rule) => SizedBox(
                    width: Get.width,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          width: 2, // Border width
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Text(
                          rule,
                          style: TextStyle(
                            fontSize: AppConfig.smallBodyFontSize,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                width: Get.width,
                height: 130,
                child: CustomDatePicker(
                  onDateSelected: (selectedDate) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                    bookingsController.bookingDate.value = formattedDate;
                  },
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: () {
                  Get.to(() => const GolfCourseScreen(),
                      transition: Transition.cupertino);
                },
                text: 'N E X T',
                isLoading: false,
                tag: '0',
              )
            ],
          ),
        ),
      ),
    );
  }
}
