import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/exam_room.dart';
import 'package:valua_camera/models/room.dart';
import 'package:valua_camera/models/shift.dart';

part 'assigned_exam_room.g.dart';

@JsonSerializable()
class AssignedExamRoom {
  Room currentRoom;
  int totalAttendances;
  Shift currentShift;
  List<ExamRoom> examRooms;

  AssignedExamRoom({
    required this.currentRoom,
    required this.totalAttendances,
    required this.currentShift,
    required this.examRooms,
  });

  factory AssignedExamRoom.fromJson(Map<String, dynamic> json) =>
      _$AssignedExamRoomFromJson(json);
  Map<String, dynamic> toJson() => _$AssignedExamRoomToJson(this);
}
