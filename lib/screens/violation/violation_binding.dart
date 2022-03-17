import 'package:get/get.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/screens/violation/violation_controller.dart';

class ViolationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViolationController>(() => ViolationController());
    Get.lazyPut<ReportProvider>(() => ReportProvider());
  }
}
