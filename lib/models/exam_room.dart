import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/attendances.dart';
import 'package:valua_camera/models/auth_user.dart';
import 'package:valua_camera/models/room.dart';
import 'package:valua_camera/models/shift.dart';
import 'package:valua_camera/models/subject.dart';
part 'exam_room.g.dart';

@JsonSerializable()
class ExamRoom {
  String examRoomId;
  String examRoomName;
  Shift? shift;
  AuthUser? staff;
  Room? room;
  Subject? subject;
  Attendances attendances;
  int status;
  String createdDate;
  String lastModifiedDate;

  ExamRoom({
    required this.examRoomId,
    required this.examRoomName,
    this.shift,
    this.staff,
    this.room,
    this.subject,
    required this.attendances,
    required this.status,
    required this.createdDate,
    required this.lastModifiedDate,
  });

  factory ExamRoom.fromJson(Map<String, dynamic> json) =>
      _$ExamRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ExamRoomToJson(this);
}
