import 'package:get/get.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/screens/detail_incident/detail_incident_controller.dart';

class DetailIncidentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailIncidentController>(() => DetailIncidentController());
    Get.lazyPut<ReportProvider>(() => ReportProvider());
  }
}
