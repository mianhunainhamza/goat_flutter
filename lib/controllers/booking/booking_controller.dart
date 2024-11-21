import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:goat_flutter/controllers/user/user_controller.dart';
import 'package:goat_flutter/models/golf_course/golf_course_model.dart';
import 'package:intl/intl.dart';

import '../../models/booking/booking_model.dart';
import '../../models/tee_time/tee_time_model.dart';
import '../../models/user/user_model.dart';
import '../../widgets/custom_snackbar.dart';

class BookingsController extends GetxController {
  var bookingDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('bookings');
  var isSportFullyBookedCache = {}.obs;

  var bookings = <BookingModel>[].obs;
  var isLoading = false.obs;
  var isConfirmationLoading = false.obs;

  //used to store temp values for booking
  var selectedTeeTimeModel = Rxn<TeeTimeModel>();
  var selectedGolfCourseModel = Rxn<GolfCourseModel>();
  var weekEndRestriction = ''.obs;
  var fridayRestriction = ''.obs;
  var selectedTee = ''.obs;
  var selectedTeeTime = ''.obs;

  void resetBookingData() {
    selectedTeeTimeModel.value = null;
    weekEndRestriction.value = '';
    fridayRestriction.value = '';
    selectedTeeTime.value = '';
    selectedTee.value = '';
  }

  @override
  void close() {
    super.onInit();
    resetBookingData();
  }

  Future<bool> addBooking({
    required String golfCourseNo,
    required String teeTimeName,
    required String teeTimeId,
    required String timeSlot,
    required String bookingDate,
    required BuildContext context,
  }) async {
    try {
      isConfirmationLoading.value = true;
      final DatabaseReference bookingsRef =
          FirebaseDatabase.instance.ref('bookings');
      final userController = Get.find<UserController>();
      final user = userController.userModel.value;

      if (user == null) {
        throw Exception("User not logged in.");
      }

      if (user.role == 'admin') {
        print("User is an admin.");
        return await _processBooking(bookingsRef, user, golfCourseNo,
            teeTimeName, timeSlot, bookingDate, context);
      }

      // Restriction: User can't book after 7 PM in their time zone
      final userTimeZone = user.timeZone;
      print("User Time Zone: $userTimeZone");

      if (userTimeZone == null || userTimeZone.isEmpty) {
        throw Exception("User timezone is missing.");
      }

      final offsetString = userTimeZone.split('UTC')[1];
      final offsetHours = int.parse(offsetString.split(':')[0]);

      final nowInUserTZ =
          DateTime.now().toUtc().add(Duration(hours: offsetHours));

      if (nowInUserTZ.hour >= 19) {
        CustomSnackbar.showSnackBar(
          'Booking Restriction',
          'No bookings are allowed after 7 PM in your timezone.',
          const Icon(Icons.warning_amber),
          context,
        );
        print("Current time is after 7 PM in the user's time zone.");
        return false;
      }

      // Restriction 2: Check if the user has an existing booking on the same date, same golf course, and same tee time
      final snapshot = await bookingsRef
          .orderByChild('user')
          .equalTo(user.userId)
          .limitToLast(20)
          .get();

      final existingBookings = snapshot.children.map((child) {
        final map = child.value as Map<dynamic, dynamic>;
        return BookingModel.fromMap(map);
      }).toList();
      print("Existing bookings:");
      for (var booking in existingBookings) {
        print("Golf Course: ${booking.golfCourse}");
        print("Tee Time: ${booking.teeTimeName}");
        print("Booking Date: ${booking.bookingDate}");
        print("User: ${booking.user}");
      }
      final fullDateTimeString =
          '$bookingDate ${timeSlot.replaceAll('-', ' ')}';

      final bookingDateTime =
          DateFormat('yyyy-MM-dd h:mm a').parse(fullDateTimeString).toUtc();

      final recentBookingsInCourse = existingBookings.where((booking) {
        final existingTeeTime = DateFormat('yyyy-MM-dd h:mm a').parse(
            '${booking.bookingDate} ${booking.timeSlot.replaceAll('-', ' ')}');

        final existingTeeTimeInUTC = existingTeeTime.toUtc();

        final bookingDateTimeInUTC = bookingDateTime.toUtc();

        final timeDifference =
            bookingDateTimeInUTC.difference(existingTeeTimeInUTC).inHours;

        final isSameGolfCourse = booking.golfCourse == golfCourseNo;
        print("Existing Tee Time in UTC: $existingTeeTimeInUTC");
        print("Current Booking DateTime in UTC: $bookingDateTimeInUTC");
        print("Time Difference: $timeDifference hours");

        return isSameGolfCourse && timeDifference < 4;
      }).toList();

      if (recentBookingsInCourse.isNotEmpty) {
        CustomSnackbar.showSnackBar(
          'Booking Restriction',
          'You cannot book the same golf course within 4 hours of a previous booking.',
          const Icon(Icons.warning_amber),
          context,
        );
        print("User has a booking on the same course within 4 hours.");
        return false;
      }

      final nowUtc = DateTime.now().toUtc();
      final timeZoneOffset = parseTimeZoneOffset(user.timeZone);
      final nowInUserTimeZone = nowUtc.add(timeZoneOffset);

// Convert both timestamps to UTC for consistency
      final currentDayStartUtc = DateTime.utc(nowInUserTimeZone.year,
          nowInUserTimeZone.month, nowInUserTimeZone.day);
      final currentDayEndUtc = currentDayStartUtc.add(const Duration(days: 1));

      final bookingsToday = existingBookings.where((booking) {
        final bookingDateTimeUtc = DateTime.parse(booking.timeStamp).toUtc();

        final isSameDay = bookingDateTimeUtc.isAfter(currentDayStartUtc) &&
            bookingDateTimeUtc.isBefore(currentDayEndUtc);
        final isSameUser = booking.user == user.userId;

        return isSameDay && isSameUser;
      }).toList();

      if (bookingsToday.length >= 2) {
        CustomSnackbar.showSnackBar(
          'Booking Restriction',
          'You cannot book more than 2 tee times in a single day.',
          const Icon(Icons.warning_amber),
          context,
        );
        print("User already has 2 bookings on the same day.");
        return false;
      }

      return await _processBooking(bookingsRef, user, golfCourseNo, teeTimeName,
          timeSlot, bookingDate, context);
    } catch (e) {
      isConfirmationLoading.value = false;
      CustomSnackbar.showSnackBar(
        'Error',
        'Please try again later',
        const Icon(Icons.error, color: Colors.red),
        context,
      );
      return false;
    }
  }

  Duration parseTimeZoneOffset(String timeZone) {
    final regex = RegExp(r"UTC([+-]\d{1,2}):?(\d{2})?");
    final match = regex.firstMatch(timeZone);

    if (match != null) {
      final hours = int.parse(match.group(1)!);
      final minutes = match.group(2) != null ? int.parse(match.group(2)!) : 0;
      return Duration(hours: hours, minutes: minutes);
    } else {
      return Duration.zero;
    }
  }

  String getCurrentTimestampInUserTimeZone(String userTimeZone) {
    final offsetPart = userTimeZone.split('UTC')[1];
    final userTimeZoneOffset = int.parse(offsetPart.split(':')[0]);
    final nowInUserTimeZone =
        DateTime.now().toUtc().add(Duration(hours: userTimeZoneOffset));
    final iso8601Formatted = nowInUserTimeZone.toIso8601String();
    return iso8601Formatted;
  }

  Future<bool> _processBooking(
    DatabaseReference bookingsRef,
    UserModel user,
    String golfCourseNo,
    String teeTimeName,
    String timeSlot,
    String bookingDate,
    BuildContext context,
  ) async {
    try {
      // Ensure the user has a valid timezone
      if (user.timeZone == null || user.timeZone.isEmpty) {
        throw Exception("User timezone is missing.");
      }
      String timeStamp = getCurrentTimestampInUserTimeZone(user.timeZone);
      final bookingData = BookingModel(
        bookingDate: bookingDate,
        golfCourse: golfCourseNo,
        status: 0,
        teeTimeName: teeTimeName,
        timeStamp: timeStamp,
        timeSlot: timeSlot,
        user: user.userId,
        userName: user.name,
      );

      await bookingsRef.push().set(bookingData.toJson());
      fetchBookings(golfCourseNo);
      CustomSnackbar.showSnackBar(
        'Success',
        'Your booking has been confirmed!',
        const Icon(Icons.check_circle, color: Colors.green),
        context,
      );
      return true;
    } catch (e) {
      isConfirmationLoading.value = false;
      CustomSnackbar.showSnackBar(
        'Error',
        'There was an issue with your booking. Please try again later.',
        const Icon(Icons.error, color: Colors.red),
        context,
      );
      return false;
    }
  }

//fetch booking of a golf course
  Future<void> fetchBookings(String golfCourse) async {
    try {
      isLoading.value = true;
      Query query = _dbRef.orderByChild('golf_course').equalTo(golfCourse);

      final snapshot = await query.get();

      if (snapshot.exists) {
        List<BookingModel> fetchedBookings = [];
        for (var child in snapshot.children) {
          Map<dynamic, dynamic>? data = child.value as Map<dynamic, dynamic>?;
          if (data != null &&
              data['booking_date'] == bookingDate.value &&
              data['status'] == 0) {
            fetchedBookings.add(BookingModel.fromMap(data));
          }
        }
        bookings.value = fetchedBookings;
      } else {
        bookings.clear();
      }
    } catch (e) {
      print("Error fetching bookings: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Filter tee times based on restrictions
  List<String> filterTeeTimes({
    required List<String> teeTimes,
    required String weekEndRestriction,
    required String fridayRestriction,
  }) {
    final bookingDateTime = DateFormat('yyyy-MM-dd').parse(bookingDate.value);
    final isWeekend = bookingDateTime.weekday == DateTime.saturday ||
        bookingDateTime.weekday == DateTime.sunday;
    final isFriday = bookingDateTime.weekday == DateTime.friday;

    final restrictionTime = isWeekend
        ? weekEndRestriction.isNotEmpty
            ? _parseTime(weekEndRestriction)
            : null
        : isFriday
            ? fridayRestriction.isNotEmpty
                ? _parseTime(fridayRestriction)
                : null
            : null;

    List<String> filteredTeeTimes = restrictionTime == null
        ? teeTimes
        : teeTimes.where((time) {
            final slotTime = _parseTime(time);
            return slotTime != null &&
                (slotTime.isAfter(restrictionTime) ||
                    slotTime.isAtSameMomentAs(restrictionTime));
          }).toList();

    filteredTeeTimes.sort((a, b) {
      final timeA = _parseTime(a);
      final timeB = _parseTime(b);
      if (timeA == null || timeB == null) return 0;
      return timeA.compareTo(timeB);
    });

    return filteredTeeTimes;
  }

// Helper function to parse time from h:mm a (12-hour format with AM/PM)
  DateTime? _parseTime(String time) {
    try {
      final parsedTime = DateFormat('h:mm a').parse(time);
      return DateTime(2000, 1, 1, parsedTime.hour, parsedTime.minute);
    } catch (e) {
      return null;
    }
  }

  Future<bool> isSportFullyBooked(
      String golfCourseId, String bookingDate, int sportsAllowed) async {
    try {
      final cacheKey = '$golfCourseId-$bookingDate';
      if (isSportFullyBookedCache.containsKey(cacheKey)) {
        return isSportFullyBookedCache[cacheKey]!;
      }
      print('cheking');

      // Query Firebase if not cached
      DatabaseReference bookingRef = FirebaseDatabase.instance.ref('bookings');
      DataSnapshot snapshot = await bookingRef
          .orderByChild('golf_course')
          .equalTo(golfCourseId)
          .get();
      if (snapshot.exists) {
        Map<dynamic, dynamic> bookings =
            snapshot.value as Map<dynamic, dynamic>;
        int bookedCount = bookings.values.where((booking) {
          return booking['booking_date'] == bookingDate;
        }).length;

        bool fullyBooked = bookedCount >= sportsAllowed;
        isSportFullyBookedCache[cacheKey] = fullyBooked;
        return fullyBooked;
      }
      return false;
    } catch (e) {
      print("Error fetching bookings: $e");
      return false;
    }
  }
}
