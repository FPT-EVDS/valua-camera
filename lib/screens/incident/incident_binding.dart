import 'package:get/get.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/screens/incident/incident_controller.dart';

class IncidentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncidentController>(() => IncidentController());
    Get.lazyPut<ReportProvider>(() => ReportProvider());
  }
}
