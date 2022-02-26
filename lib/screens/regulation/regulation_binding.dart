import 'package:get/get.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/providers/regulation_provider.dart';
import 'package:valua_camera/screens/regulation/regulation_controller.dart';

class RegulationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegulationController>(() => RegulationController());
    Get.lazyPut<RegulationProvider>(() => RegulationProvider());
    Get.lazyPut<ExamRoomProvider>(() => ExamRoomProvider());
  }
}
