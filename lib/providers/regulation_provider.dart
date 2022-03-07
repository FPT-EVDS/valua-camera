import 'package:get/get.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/regulation_repository.dart';

class RegulationProvider extends BaseProvider implements RegulationRepository {
  @override
  Future<Report> submitReport(
    String description,
    String note,
    String? imageUrl,
    String violatorId,
    String examRoomId,
  ) async {
    final form = FormData({
      'report': [
        {
          'description': description,
          'note': note,
          'violatorId': violatorId,
          'examRoom': {
            'examRoomId': examRoomId,
          },
        },
      ],
      'imageUrl': null,
    });
    final response = await post(
      "/reports",
      form,
      contentType: "multipart/form-data",
    );
    if (response.status.hasError) {
      throw (response.body);
    }
    return Report.fromJson(response.body);
  }
}
