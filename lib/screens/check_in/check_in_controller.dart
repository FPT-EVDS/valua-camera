import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:valua_camera/models/exam_room.dart';

class CheckInController extends GetxController {
  final ExamRoom examRoom = Get.arguments;
  final takenImage = Rx<XFile?>(null);
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      // Get front camera
      final frontCamera = cameras[1];
      cameraController = CameraController(frontCamera, ResolutionPreset.medium);
      initializeControllerFuture = cameraController.initialize();
    }
    super.onInit();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
