import 'package:flutter/material.dart';
import '../../../config/app_config.dart';
import '../../../models/booking/booking_model.dart';

Widget buildMinimalBookingCard(BookingModel booking, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          booking.timeSlot,
          style: TextStyle(
            fontSize: AppConfig.bodyFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Text(
        //   " - ${booking.teeTimeName}",
        //   style: TextStyle(
        //     fontSize: AppConfig.bodyFontSize,
        //   ),
        // ),
        Text(
          " - ${booking.userName}",
          style: TextStyle(
            fontSize: AppConfig.bodyFontSize,
          ),
        ),
      ],
    ),
  );
}
