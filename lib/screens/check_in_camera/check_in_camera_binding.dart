import 'package:get/get.dart';
import 'package:valua_camera/screens/check_in_camera/check_in_camera_controller.dart';

class CheckInCameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckInCameraController>(() => CheckInCameraController());
  }
}
