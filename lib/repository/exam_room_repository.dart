import 'package:valua_staff/models/exam_room.dart';

abstract class ExamRoomRepository {
  Future<ExamRoom> loadExamRoom();
}
