import 'package:get/get.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/screens/dashboard/dashboard_controller.dart';
import 'package:valua_camera/screens/detail_violation/detail_violation_controller.dart';

class DetailViolationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailViolationController>(() => DetailViolationController());
    Get.lazyPut<ReportProvider>(() => ReportProvider());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
