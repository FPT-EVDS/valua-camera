import 'package:get/get.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/screens/report/report_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(() => ReportController());
    Get.lazyPut<ReportProvider>(() => ReportProvider());
  }
}
