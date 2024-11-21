class BookingModel {
  final String bookingDate;
  final String golfCourse;
  final int status;
  final String teeTimeName;
  final String timeStamp;
  final String timeSlot;
  final String user;
  final String userName;

  BookingModel({
    required this.bookingDate,
    required this.golfCourse,
    required this.status,
    required this.teeTimeName,
    required this.timeStamp,
    required this.timeSlot,
    required this.user,
    required this.userName,
  });

  // Factory constructor to create a BookingModel from a map
  factory BookingModel.fromMap(Map<dynamic, dynamic> map) {
    return BookingModel(
      bookingDate: map['booking_date'] ?? '',
      golfCourse: map['golf_course'] ?? '',
      status: map['status'] ?? 0,
      teeTimeName: map['tee_time_name'] ?? '',
      timeStamp: map['timeStamp'] ?? '',
      timeSlot: map['time_slot'] ?? '',
      user: map['user'] ?? '',
      userName: map['user_name'] ?? '',
    );
  }

  // Factory constructor to create a BookingModel from JSON
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingDate: json['booking_date'] ?? '',
      golfCourse: json['golf_course'] ?? '',
      status: json['status'] ?? 0,
      teeTimeName: json['tee_time_name'] ?? '',
      timeStamp: json['timeStamp'] ?? '',
      timeSlot: json['time_slot'] ?? '',
      user: json['user'] ?? '',
      userName: json['user_name'] ?? '',
    );
  }

  // Convert BookingModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'booking_date': bookingDate,
      'golf_course': golfCourse,
      'status': status,
      'tee_time_name': teeTimeName,
      'timeStamp': timeStamp,
      'time_slot': timeSlot,
      'user': user,
      'user_name': userName,
    };
  }

  // Empty instance of BookingModel
  factory BookingModel.empty() {
    return BookingModel(
      golfCourse: '',
      bookingDate: '',
      teeTimeName: '',
      timeSlot: '',
      status: 0,
      timeStamp: '',
      user: '',
      userName: '',
    );
  }

  bool get isNotEmpty =>
      golfCourse.isNotEmpty && bookingDate.isNotEmpty &&
          teeTimeName.isNotEmpty && timeSlot.isNotEmpty;
}
