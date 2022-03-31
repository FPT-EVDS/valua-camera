import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/account_alternative.dart';
import 'package:valua_camera/models/attempt.dart';
part 'current_attendance.g.dart';

@JsonSerializable()
class CurrentAttendance {
  CurrentAttendanceClass currentAttendance;

  CurrentAttendance({
    required this.currentAttendance,
  });

  factory CurrentAttendance.fromJson(Map<String, dynamic> json) =>
      _$CurrentAttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentAttendanceToJson(this);
}

@JsonSerializable()
class CurrentAttendanceClass {
  String attendanceId;
  SubjectExaminee subjectExaminee;
  int position;
  ExamRoom examRoom;
  List<Attempt> attempts;
  DateTime? startTime;
  DateTime? finishTime;
  DateTime createdDate;
  DateTime lastModified;

  CurrentAttendanceClass({
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

  factory CurrentAttendanceClass.fromJson(Map<String, dynamic> json) =>
      _$CurrentAttendanceClassFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentAttendanceClassToJson(this);
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

@JsonSerializable()
class SubjectExaminee {
  String subjectExamineeId;
  AccountAlternative examinee;
  int status;
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
