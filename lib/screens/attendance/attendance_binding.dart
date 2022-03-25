import 'package:get/get.dart';
import 'package:valua_camera/providers/attendance_provider.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/screens/attendance/attendance_controller.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceController>(() => AttendanceController());
    Get.lazyPut<ExamRoomProvider>(() => ExamRoomProvider());
    Get.lazyPut<AttendanceProvider>(() => AttendanceProvider());
  }
}
