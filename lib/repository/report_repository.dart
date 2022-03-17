import 'package:get/get.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/models/report_overview.dart' hide Report;

abstract class ReportRepository {
  Future<Report> createReport(FormData formData);
  Future<Report> updateReport(String reportId, FormData formData);
  Future<Report> getReport(String reportId);
  Future<ReportOverview> getReportOverview();
}
