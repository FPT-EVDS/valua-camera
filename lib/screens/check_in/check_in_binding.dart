import 'package:get/get.dart';
import 'package:valua_camera/screens/check_in/check_in_controller.dart';

class CheckInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckInController>(() => CheckInController());
  }
}
