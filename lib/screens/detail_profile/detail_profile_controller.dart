import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProfileController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }
}
