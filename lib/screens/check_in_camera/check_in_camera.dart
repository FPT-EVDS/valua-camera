import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valua_camera/screens/check_in_camera/check_in_camera_controller.dart';

class CheckInCameraScreen extends StatelessWidget {
  const CheckInCameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<CheckInCameraController>();
    final size = MediaQuery.of(context).size;
    var scale =
        size.aspectRatio * _controller.cameraController.value.aspectRatio;
    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Transform.scale(
              scale: scale,
              child: Center(
                child: CameraPreview(_controller.cameraController),
              ),
            ),
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
