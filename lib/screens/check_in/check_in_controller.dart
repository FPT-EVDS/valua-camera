import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';

class CheckInController extends GetxController {
  final AssignedExamRoom examRoom = Get.arguments;
  final takenImage = Rx<XFile?>(null);
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;

  Future<CameraDescription> getCamera(CameraLensDirection direction) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == direction,
      ),
    );
  }

  @override
  void onInit() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      // Get front camera
      CameraDescription cameraDescription =
          await getCamera(CameraLensDirection.front);
      cameraController =
          CameraController(cameraDescription, ResolutionPreset.high);
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
