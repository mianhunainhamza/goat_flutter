import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/config/app_config.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CustomDatePicker({super.key, required this.onDateSelected});

  @override
  CustomDatePickerState createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _selectedDate = DateTime.now();
  int _currentIndex = 0;

  // Get days for the current 7-day period based on the period index
  List<DateTime> _getDaysForPeriod(int periodIndex) {
    List<DateTime> days = [];
    DateTime startDay = _getStartOfWeek().add(Duration(days: periodIndex * 7));

    for (int i = 0; i < 7; i++) {
      days.add(startDay.add(Duration(days: i)));
    }

    return days;
  }

  DateTime _getStartOfWeek() {
    DateTime today = DateTime.now();
    int daysToSubtract = today.weekday - DateTime.monday;
    return today.subtract(Duration(days: daysToSubtract));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> days = _getDaysForPeriod(_currentIndex);
    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    String displayedMonth = _getMonthString(days.first.month);
    if (days.first.month != days.last.month) {
      displayedMonth = '${_getMonthString(days.first.month)} / ${_getMonthString(days.last.month)}';
    }

    return Column(
      children: [

        // Month/Year with arrows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Ionicons.chevron_back,
                color: _currentIndex > 0 ? primaryColor : primaryColor.withOpacity(0.2),
              ),
              onPressed: _currentIndex > 0
                  ? () {
                setState(() {
                  _currentIndex--;
                });
              }
                  : null,
            ),
            Text(
              '$displayedMonth ${days.first.year}',
              style: TextStyle(
                fontSize: AppConfig.subheadingFontSize,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            IconButton(
              icon: Icon(
                Ionicons.chevron_forward,
                color: _currentIndex < 2 ? primaryColor : primaryColor.withOpacity(0.5),
              ),
              onPressed: _currentIndex < 2
                  ? () {
                setState(() {
                  _currentIndex++;
                });
              }
                  : null,
            ),
          ],
        ),
        // Days Row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: days.map((day) {
              bool isSelected = _isSameDay(day, _selectedDate);
              bool isSelectable = !day.isBefore(DateTime.now().toLocal().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0));

              return GestureDetector(
                onTap: isSelectable
                    ? () {
                  setState(() {
                    _selectedDate = day;
                    if (_selectedDate.isBefore(DateTime.now())) {
                      _selectedDate = DateTime.now();
                    }
                  });
                  widget.onDateSelected(_selectedDate);
                }
                    : null,
                child: Container(
                  width: Get.width * .111,
                  height: 75,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? secondaryColor
                          : primaryColor.withOpacity(0.5),
                      width: isSelectable ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E').format(day),
                        style: TextStyle(
                          fontSize: AppConfig.smallBodyFontSize,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? secondaryColor
                              : isSelectable
                              ? primaryColor.withOpacity(0.7)
                              : primaryColor.withOpacity(0.3),
                        ),
                      ),
                      Text(
                        day.day.toString(),
                        style: TextStyle(
                          fontSize: AppConfig.smallBodyFontSize,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? secondaryColor
                              : isSelectable
                              ? primaryColor
                              : primaryColor.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Helper function to convert month number to string
  String _getMonthString(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  bool _isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year && day1.month == day2.month && day1.day == day2.day;
  }
}
