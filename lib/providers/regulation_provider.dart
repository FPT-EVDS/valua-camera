import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/regulation_repository.dart';

class RegulationProvider extends BaseProvider implements RegulationRepository {
  @override
  Future<String> submitReport(
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
      'examRoomId': examRoomId,
    });
    if (response.status.hasError) {
      throw (response.body);
    }
    return response.body;
  }
}
