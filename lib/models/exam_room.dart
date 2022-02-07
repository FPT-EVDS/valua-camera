import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/attendance.dart';
import 'package:valua_camera/models/account_alternative.dart';
import 'package:valua_camera/models/room.dart';
import 'package:valua_camera/models/shift.dart';
import 'package:valua_camera/models/subject.dart';
part 'exam_room.g.dart';

@JsonSerializable()
class ExamRoom {
  String examRoomId;
  String examRoomName;
  Shift shift;
  AccountAlternative staff;
  Room room;
  Subject subject;
  List<Attendance> attendances;
  int status;
  DateTime createdDate;
  DateTime lastModifiedDate;

  ExamRoom({
    required this.examRoomId,
    required this.examRoomName,
    required this.shift,
    required this.staff,
    required this.room,
    required this.subject,
    required this.attendances,
    required this.status,
    required this.createdDate,
    required this.lastModifiedDate,
  });

  factory ExamRoom.fromJson(Map<String, dynamic> json) =>
      _$ExamRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ExamRoomToJson(this);
}
