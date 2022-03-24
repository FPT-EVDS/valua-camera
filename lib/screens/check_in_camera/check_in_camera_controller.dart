import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soundpool/soundpool.dart';

class CheckInCameraController extends GetxController {
  // Define the camera timer (in second) duration here
  static const cameraTimerDuration = 5;
  final takenImage = Rx<XFile?>(null);
  late final Timer _timer;
  late final Soundpool _soundpool;
  late final int _soundId;
  final timeRemaining = 5.obs;
  CameraController cameraController = Get.arguments;

  @override
  void onInit() async {
    _soundpool = Soundpool.fromOptions(options: SoundpoolOptions.kDefault);
    _soundId = await rootBundle
        .load("assets/sounds/camera.mp3")
        .then((soundData) => _soundpool.load(soundData));
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    _timer.cancel();
    _soundpool.dispose();
    cameraController.dispose();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (timeRemaining.value == 0) {
          timer.cancel();
          // take picture
          takenImage.value = await cameraController.takePicture();
          _soundpool.play(_soundId);
          Get.back(result: takenImage.value);
        } else {
          timeRemaining.value -= 1;
        }
      },
    );
  }
}
