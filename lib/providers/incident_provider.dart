import 'package:get/get.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/incident_repository.dart';

class IncidentProvider extends BaseProvider implements IncidentRepository {
  @override
  Future<Report> submitReport(
    String description,
    String note,
    String examRoomId,
    String? imageUrl,
  ) async {
    final form = FormData({
      'contentType': "multipart/form-data",
      'report': {
        'description': description,
        'note': note,
        'examRoom': {
          'examRoomId': examRoomId,
        },
        'reportType': 1,
      },
      'image': imageUrl,
    });
    final response = await post("/reports", form);
    if (response.status.hasError) {
      throw (response.body);
    }
    return Report.fromJson(response.body);
  }
}
