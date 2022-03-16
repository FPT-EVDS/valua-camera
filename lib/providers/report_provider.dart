import 'package:get/get.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/report_repository.dart';

class ReportProvider extends BaseProvider implements ReportRepository {
  @override
  Future<Report> createReport(FormData formData) async {
    final response = await post("/reports", formData);
    if (response.status.hasError) {
      throw response.body;
    }
    return Report.fromJson(response.body);
  }
}
