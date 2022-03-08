import 'package:valua_camera/models/report_list.dart';

abstract class ReportRepository {
  Future<ReportList> getReport();
}
