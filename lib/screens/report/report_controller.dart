import 'package:get/get.dart';
import 'package:valua_camera/models/report_overview.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/repository/report_repository.dart';

class ReportController extends GetxController {
  final reportOverview = Rx<ReportOverview?>(null);
  final ReportRepository _provider = Get.find<ReportProvider>();

  Future<ReportOverview> getReportOverview({DateTime? date}) async {
    try {
      final data = _provider.getReportOverview().then((value) {
        reportOverview.value = value;
        return value;
      });
      return data;
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  void onInit() {
    getReportOverview();
    super.onInit();
  }
}
