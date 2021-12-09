import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:evds_staff/models/account.dart';
import 'package:evds_staff/providers/auth_provider.dart';
import 'package:evds_staff/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DetailProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final Account currentUser;
  final genders = ["Male", "Female"].obs;
  late TextEditingController emailController,
      phoneController,
      birthdateController,
      addressController;
  late final dynamic gender;
  final AuthRepository _provider = Get.find<AuthProvider>();
  final isLoading = false.obs;
  final GetStorage _storage = GetStorage();
  final DateFormat _dateFormat = DateFormat("dd/MM/yyyy");

  @override
  void onInit() {
    currentUser = Account.fromJson(jsonDecode(_storage.read("user")));
    emailController = TextEditingController(text: currentUser.email);
    birthdateController = TextEditingController(
        text: _dateFormat.format(DateTime.parse(currentUser.birthdate)));
    phoneController = TextEditingController(text: currentUser.phoneNumber);
    addressController = TextEditingController(text: currentUser.address);
    gender = currentUser.gender.toString().obs;
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    birthdateController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateFormat.parse(birthdateController.text),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      birthdateController.text = _dateFormat.format(picked);
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        final Account account = currentUser;
        account.gender = genders.indexOf(gender);
        account.address = addressController.text;
        account.phoneNumber = phoneController.text;
        account.birthdate = DateFormat("yyyy-MM-dd")
            .format(_dateFormat.parse(birthdateController.text));
        final Account data = await _provider.updateProfile(account);
        data.gender = gender.value;
        _storage.write("user", jsonEncode(data));
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Update profile success",
        );
      } catch (e) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: e.toString(),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
