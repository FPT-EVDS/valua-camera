import 'package:valua_camera/models/report.dart';

abstract class IncidentRepository {
  Future<Report> submit(String description, String note);
}
