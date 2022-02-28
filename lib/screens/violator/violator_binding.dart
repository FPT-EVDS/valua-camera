import 'package:get/get.dart';
import 'package:valua_camera/screens/violator/violator_controller.dart';

class ViolatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViolatorController>(() => ViolatorController());
  }
}
