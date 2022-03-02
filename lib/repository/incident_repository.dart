import 'package:valua_camera/models/report.dart';

abstract class IncidentRepository {
  Future<Report> submitReport(
    String description,
    String note,
    String examRoomId,
    String? imageUrl,
  );
}
