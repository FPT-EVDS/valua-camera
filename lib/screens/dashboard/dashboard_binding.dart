import 'package:get/get.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/screens/dashboard/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<ExamRoomProvider>(() => ExamRoomProvider());
  }
}
