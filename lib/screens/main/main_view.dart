import 'package:valua_staff/models/exam_room.dart';
import 'package:valua_staff/models/shift.dart';

abstract class MainView {
  void loadExamRoom(ExamRoom examRoom);

  void showEmptyExamRoom() {}
}
