import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/account_alternative.dart';
part 'check_attendance.g.dart';

@JsonSerializable()
class CheckAttendance {
  Attendance attendance;

  CheckAttendance({
    required this.attendance,
  });

  factory CheckAttendance.fromJson(Map<String, dynamic> json) =>
      _$CheckAttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$CheckAttendanceToJson(this);
}

@JsonSerializable()
class Attendance {
  String attendanceId;
  AccountAlternative examinee;
  int position;
  ExamRoom examRoom;
  List<dynamic> attempts;
  DateTime? startTime;
  DateTime? finishTime;
  DateTime createdDate;
  DateTime lastModified;

  Attendance({
    required this.attendanceId,
    required this.examinee,
    required this.position,
    required this.examRoom,
    required this.attempts,
    this.startTime,
    this.finishTime,
    required this.createdDate,
    required this.lastModified,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}

@JsonSerializable()
class ExamRoom {
  String examRoomId;
  String examRoomName;

  ExamRoom({
    required this.examRoomId,
    required this.examRoomName,
  });

  factory ExamRoom.fromJson(Map<String, dynamic> json) =>
      _$ExamRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ExamRoomToJson(this);
}
