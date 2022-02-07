import 'package:get/get.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/screens/main/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<ExamRoomProvider>(() => ExamRoomProvider());
  }
}
