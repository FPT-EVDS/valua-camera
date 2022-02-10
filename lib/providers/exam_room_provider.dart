import 'package:valua_camera/models/exam_room.dart';
import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';

class ExamRoomProvider extends BaseProvider implements ExamRoomRepository {
  @override
  Future<ExamRoom> loadExamRoom() async {
    final response = await get("/examRooms/assigned/now");
    if (response.status.hasError) {
      throw (response.body);
    }
    return ExamRoom.fromJson(response.body);
  }
}
