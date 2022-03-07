import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valua_camera/screens/check_in_camera/check_in_camera_controller.dart';

class CheckInCameraScreen extends StatelessWidget {
  const CheckInCameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<CheckInCameraController>();
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: 0,
            bottom: 0,
            child: CameraPreview(_controller.cameraController),
          ),
          Center(
            child: Obx(
              () => Text(
                _controller.timeRemaining.value == 0
                    ? ''
                    : _controller.timeRemaining.value.toString(),
                style: const TextStyle(fontSize: 84, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
