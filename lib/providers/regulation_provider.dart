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
    final response = await post("/reports", {
      'description': description,
      'note': note,
      'imageUrl': imageUrl,
      'violatorId': violatorId,
      'examRoom': {
        'examRoomId': examRoomId,
      },
    });
    if (response.status.hasError) {
      throw (response.body);
    }
    return Report.fromJson(response.body);
  }
}
