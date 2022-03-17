import 'package:get/get.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/models/report_overview.dart' hide Report;
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

  @override
  Future<ReportOverview> getReportOverview() async {
    final response = await get("/reports/assigned/now");
    if (response.status.hasError) {
      throw response.body;
    }
    return ReportOverview.fromJson(response.body);
  }

  @override
  Future<Report> getReport(String reportId) async {
    final response = await get("/reports/$reportId");
    if (response.status.hasError) {
      throw response.body;
    }
    return Report.fromJson(response.body);
  }

  @override
  Future<Report> updateReport(String reportId, FormData formData) async {
    final response = await put("/reports/$reportId", formData);
    if (response.status.hasError) {
      throw response.body;
    }
    return Report.fromJson(response.body);
  }
}
