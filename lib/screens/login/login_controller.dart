import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/providers/auth_provider.dart';
import 'package:valua_camera/repository/auth_repository.dart';
import 'package:valua_camera/routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  final isLoading = false.obs;
  final AuthRepository _provider = Get.find<AuthProvider>();
  final GetStorage _storage = GetStorage(AppConstant.storageKey);
  final _googleSignIn = GoogleSignIn();

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

  void login() async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      try {
        isLoading.value = true;
        final data = await _provider.login(email, password);
        if (data.appUser.role == "Staff") {
          _storage.write(AppConstant.appUser, jsonEncode(data.appUser));
          _storage.write(AppConstant.accessToken, data.token);
          _storage.write(AppConstant.refreshToken, data.appUser.refreshToken);
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

  void loginWithGoogle() async {
    try {
      final googleAccount = await _googleSignIn.signIn();
      final googleAuthentication = await googleAccount?.authentication;
      if (googleAuthentication?.idToken != null) {
        final idToken = googleAuthentication!.idToken.toString();
        final data = await _provider.loginWithGoogle(idToken);
        if (data.appUser.role == "Staff") {
          _storage.write(AppConstant.appUser, jsonEncode(data.appUser));
          _storage.write(AppConstant.accessToken, data.token);
          _storage.write(AppConstant.refreshToken, data.appUser.refreshToken);
          Get.offAllNamed(AppRoutes.main);
        } else {
          throw ("Invalid role!");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.grey.shade700,
      );
    } finally {
      final isSignedIn = await _googleSignIn.isSignedIn();
      if (isSignedIn) {
        _googleSignIn.disconnect();
      }
    }
  }
}
