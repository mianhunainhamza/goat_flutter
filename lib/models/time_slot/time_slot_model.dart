class TimeSlotModel {
  final String time;

  TimeSlotModel({
    required this.time,
  });

  factory TimeSlotModel.fromMap(Map<String, dynamic> map) {
    return TimeSlotModel(
      time: map['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
    };
  }
}