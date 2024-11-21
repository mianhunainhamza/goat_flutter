import 'package:flutter/material.dart';
import '../../../config/app_config.dart';
import '../../../models/booking/booking_model.dart';

Widget buildBookingCard(BookingModel booking, BuildContext context) {
  return Card(
    color: Theme.of(context).colorScheme.secondary,
    margin: const EdgeInsets.all(8.0),
    elevation: 1,
    shadowColor: Theme.of(context).colorScheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                radius: 20,
                child: Text(
                  booking.userName.isNotEmpty ? booking.userName[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                booking.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppConfig.subheadingFontSize,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "Time Slot: ${booking.timeSlot}",
            style: TextStyle(
              fontSize: AppConfig.bodyFontSize,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Tee Time: ${booking.teeTimeName}",
            style: TextStyle(
              fontSize: AppConfig.bodyFontSize,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Booking date: ${booking.bookingDate}",
            style: TextStyle(
              fontSize: AppConfig.bodyFontSize,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
  );
}