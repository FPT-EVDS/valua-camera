import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ShiftController extends GetxController {
  CalendarFormat calendarFormat = CalendarFormat.week;
  Rx<DateTime> currentFocusedDay = DateTime.now().obs;
  final Rx<DateTime> _selectedDay = DateTime.now().obs;

  bool selectedDatePredicate(DateTime? day) =>
      isSameDay(_selectedDay.value, day);

  void handleSelectDate(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay.value, selectedDay)) {
      _selectedDay.value = selectedDay;
      currentFocusedDay.value = focusedDay;
    }
  }

  void handleChangePage(DateTime focusedDay) {
    currentFocusedDay.value = focusedDay;
  }

  Future<void> handleDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDay.value,
      firstDate: DateTime.utc(2021, 1, 1),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      handleSelectDate(pickedDate, pickedDate);
    }
  }
}
