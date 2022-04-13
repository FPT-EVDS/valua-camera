import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';

class ExamRoomProvider extends BaseProvider implements ExamRoomRepository {
  @override
  Future<AssignedExamRoom> loadExamRoom() async {
    final response = await get("/examRooms/assigned/now");
    if (response.status.hasError) {
      throw (response.body);
    }
    return AssignedExamRoom.fromJson(response.body);
  }

  @override
  Future<bool> finishChecking() async {
    final response = await patch("/examRooms/finishChecking", {});
    if (response.status.hasError) {
      throw (response.body);
    }
    return true;
  }

  @override
  Future<bool> finishExam() async {
    final response = await patch("/examRooms/finishExam", {});
    if (response.status.hasError) {
      throw (response.body);
    }
    return true;
  }
}
