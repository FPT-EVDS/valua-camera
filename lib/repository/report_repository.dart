import 'package:get/get.dart';
import 'package:valua_camera/models/report.dart';

abstract class ReportRepository {
  Future<Report> createReport(FormData formData);
}
