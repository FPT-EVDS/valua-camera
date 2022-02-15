import 'package:valua_camera/models/report.dart';

abstract class RegulationRepository {
  Future<Report> submit(String description, String note);
}
