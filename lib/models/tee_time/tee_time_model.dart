
import '../time_slot/time_slot_model.dart';

class TeeTimeModel {
  final String name;
  final List<TimeSlotModel> timeSlots;

  TeeTimeModel({
    required this.name,
    required this.timeSlots,
  });

  // Factory constructor to create TeeTimeModel from a map
  factory TeeTimeModel.fromMap(Map<String, dynamic> map) {
    return TeeTimeModel(
      name: map['name'] ?? '',
      timeSlots: _parseTimeSlots(map['timeSlots']),
    );
  }

  static List<TimeSlotModel> _parseTimeSlots(dynamic timeSlotsData) {
    if (timeSlotsData is Map) {
      return timeSlotsData.values.map((entry) {
        return TimeSlotModel.fromMap(Map<String, dynamic>.from(entry));
      }).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'timeSlots': timeSlots.map((slot) => slot.toJson()).toList(),
    };
  }
}