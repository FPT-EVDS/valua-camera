import 'dart:convert';

import 'package:valua_staff/providers/auth_provider.dart';
import 'package:valua_staff/repository/auth_repository.dart';
import 'package:valua_staff/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  final isLoading = false.obs;
  final AuthRepository _provider = Get.find<AuthProvider>();
  final GetStorage _storage = GetStorage('evds_examinee');

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      try {
        isLoading.value = true;
        final data = await _provider.login(email, password);
        if (data.appUser.role == "Examinee") {
          _storage.write("user", jsonEncode(data.appUser));
          _storage.write("access_token", data.token);
          _storage.write("refresh_token", data.appUser.refreshToken);
          Get.offAllNamed(AppRoutes.main);
        } else {
          throw ("Invalid role!");
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.grey.shade700,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
