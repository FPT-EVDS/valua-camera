import 'package:get/get.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/screens/exam_room/exam_room_controller.dart';

class ExamRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExamRoomController>(() => ExamRoomController());
    Get.lazyPut<ExamRoomProvider>(() => ExamRoomProvider());
  }
}
