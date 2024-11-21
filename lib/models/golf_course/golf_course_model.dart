import '../tee_time/tee_time_model.dart';

class GolfCourseModel {
  final String courseName;
  final String bookingUrl;
  final String image;
  final String phone;
  final int spotsAllowed;
  final String weekendRestrictionTill;
  final String fridayRestrictionTill;
  final int orderBy;
  final List<TeeTimeModel> teeTimes;

  GolfCourseModel({
    required this.courseName,
    required this.bookingUrl,
    required this.image,
    required this.phone,
    required this.spotsAllowed,
    required this.weekendRestrictionTill,
    required this.fridayRestrictionTill,
    required this.orderBy,
    required this.teeTimes,
  });

  factory GolfCourseModel.fromMap(Map<String, dynamic> map) {
    return GolfCourseModel(
      courseName: map['name'] ?? '',
      bookingUrl: map['bookings_url'] ?? '',
      image: map['image'] ?? '',
      phone: map['phone'].toString(),
      spotsAllowed: map['spots_allowed'] ?? 0,
      weekendRestrictionTill: map['weekend_restriction_till'] ?? '',
      fridayRestrictionTill: map['friday_restriction_till'] ?? '',
      orderBy: map['orderBy'] ?? 0,
      teeTimes: _parseTeeTimes(map['teeTimes']),
    );
  }

  static List<TeeTimeModel> _parseTeeTimes(dynamic teeTimesData) {
    if (teeTimesData is Map) {
      return teeTimesData.values.map((entry) {
        return TeeTimeModel.fromMap(Map<String, dynamic>.from(entry));
      }).toList();
    }
    return [];
  }
}




