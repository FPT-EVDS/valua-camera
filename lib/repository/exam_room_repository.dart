import 'package:valua_camera/models/assigned_exam_room.dart';

abstract class ExamRoomRepository {
  Future<AssignedExamRoom> loadExamRoom();
  Future<bool> finishChecking();
  Future<bool> finishExam();
}
