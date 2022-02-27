import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/incident_repository.dart';

class IncidentProvider extends BaseProvider implements IncidentRepository {
  @override
  Future<String> submitReport(
    String description,
    String note,
    String? imageUrl,
    String examRoomId,
  ) async {
    final response = await post("/reports", {
      'description': description,
      'note': note,
      'imageUrl': imageUrl,
      'examRoomId': examRoomId,
    });
    if (response.status.hasError) {
      throw (response.body);
    }
    return response.body;
  }
}
