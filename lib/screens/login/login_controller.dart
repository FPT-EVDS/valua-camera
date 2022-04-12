import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/models/app_user.dart';
import 'package:valua_camera/models/generated_qr.dart';
import 'package:valua_camera/models/qr_login_response.dart';
import 'package:valua_camera/providers/auth_provider.dart';
import 'package:valua_camera/providers/qr_provider.dart';
import 'package:valua_camera/repository/auth_repository.dart';
import 'package:valua_camera/repository/qr_repository.dart';
import 'package:valua_camera/routes/app_pages.dart';

const socketUrl = AppConstant.apiUrl + "/websocket";

class LoginController extends GetxController {
  late StompClient stompClient;
  late TextEditingController emailController, passwordController;
  final qrData = Future<GeneratedQR?>.value().obs;
  final isLoading = false.obs;
  final AuthRepository _authProvider = Get.find<AuthProvider>();
  final QRRepository _qrProvider = Get.find<QRProvider>();
  final GetStorage _storage = GetStorage(AppConstant.storageKey);
  final _googleSignIn = GoogleSignIn();
  late dynamic unsubscribeFn;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    generateQRCode().then(
      (value) {
        stompClient = StompClient(
            config: StompConfig.SockJS(
          url: socketUrl,
          onConnect: onConnect,
          onWebSocketError: (p0) {
            Fluttertoast.showToast(
              msg: p0.toString(),
              backgroundColor: Colors.grey.shade700,
            );
          },
        ));
        stompClient.activate();
      },
    );
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    if (unsubscribeFn != null) {
      unsubscribeFn();
    }
    stompClient.deactivate();
    super.dispose();
  }

  Future<GeneratedQR?> generateQRCode() {
    try {
      final data = _qrProvider.generateQRData();
      qrData.value = data;
      return data;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.grey.shade700,
      );
    }
    throw Exception("Can't generate QR");
  }

  void checkAuthAppUser(AppUser data) {
    if (data.appUser.role == "Staff") {
      _storage.write(AppConstant.appUser, jsonEncode(data.appUser));
      _storage.write(AppConstant.accessToken, data.token);
      _storage.write(AppConstant.refreshToken, data.appUser.refreshToken);
      Get.offAllNamed(AppRoutes.main);
    } else {
      throw ("Invalid role!");
    }
  }

  void login() async {
    String email = emailController.text;
    String password = passwordController.text;
    try {
      isLoading.value = true;
      final data = await _authProvider.login(email, password);
      checkAuthAppUser(data);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.grey.shade700,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void loginWithGoogle() async {
    try {
      final googleAccount = await _googleSignIn.signIn();
      final googleAuthentication = await googleAccount?.authentication;
      if (googleAuthentication?.idToken != null) {
        final idToken = googleAuthentication!.idToken.toString();
        final data = await _authProvider.loginWithGoogle(idToken);
        checkAuthAppUser(data);
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

  void onSubscribeCallback(StompFrame stompFrame) {
    if (stompFrame.body != null) {
      try {
        final jsonData =
            jsonDecode(stompFrame.body.toString()) as Map<String, dynamic>;
        final data = QrLoginResponse.fromJson(jsonData).appUser;
        checkAuthAppUser(data);
      } catch (error) {
        Fluttertoast.showToast(
          msg: "Please refresh qr and scan again",
          backgroundColor: Colors.grey.shade700,
        );
      }
    }
  }

  void onConnect(StompFrame frame) async {
    final data = await qrData.value;
    if (data != null) {
      final topic = '/qr/token/${data.data.token}';
      unsubscribeFn = stompClient.subscribe(
        destination: topic,
        callback: onSubscribeCallback,
      );
    }
  }

  void refreshQR() {
    if (unsubscribeFn != null) {
      unsubscribeFn();
    }
    generateQRCode().then((value) {
      final data = value?.data;
      if (data != null) {
        final topic = '/qr/token/${data.token}';
        unsubscribeFn = stompClient.subscribe(
          destination: topic,
          callback: onSubscribeCallback,
        );
      }
    });
  }
}
