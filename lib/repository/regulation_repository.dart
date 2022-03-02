import 'package:valua_camera/models/report.dart';

abstract class RegulationRepository {
  Future<Report> submitReport(
    String description,
    String note,
    String? imageUrl,
    String violatorId,
    String examRoomId,
  );
}
