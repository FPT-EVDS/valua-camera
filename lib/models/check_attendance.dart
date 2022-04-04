import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/enums/subject_examinee_status.dart';
import 'package:valua_camera/models/account_alternative.dart';
import 'package:valua_camera/models/attempt.dart';
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
  SubjectExaminee subjectExaminee;
  int position;
  ExamRoom examRoom;
  List<Attempt> attempts;
  DateTime? startTime;
  DateTime? finishTime;
  DateTime createdDate;
  DateTime lastModified;

  Attendance({
    required this.attendanceId,
    required this.subjectExaminee,
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
class SubjectExaminee {
  String subjectExamineeId;
  AccountAlternative examinee;
  SubjectExamineeStatus status;
  String? removedReason;

  SubjectExaminee({
    required this.subjectExamineeId,
    required this.examinee,
    required this.status,
    this.removedReason,
  });

  factory SubjectExaminee.fromJson(Map<String, dynamic> json) =>
      _$SubjectExamineeFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectExamineeToJson(this);
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
