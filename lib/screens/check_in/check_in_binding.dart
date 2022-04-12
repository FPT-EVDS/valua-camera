import 'package:get/get.dart';
import 'package:valua_camera/providers/attendance_provider.dart';
import 'package:valua_camera/providers/auth_provider.dart';
import 'package:valua_camera/screens/check_in/check_in_controller.dart';
import 'package:valua_camera/screens/main/main_controller.dart';

class CheckInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckInController>(() => CheckInController());
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<AttendanceProvider>(() => AttendanceProvider());
    Get.lazyPut(() => AuthProvider());
  }
}
