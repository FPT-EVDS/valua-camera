import 'package:valua_camera/models/exam_room.dart';

abstract class ExamRoomRepository {
  Future<ExamRoom> getCurrentExamRoom();
}
