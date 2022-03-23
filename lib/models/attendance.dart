import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/enums/attendance_status.dart';
import 'package:valua_camera/enums/subject_examinee_status.dart';
import 'package:valua_camera/models/account_alternative.dart';

part 'attendance.g.dart';

@JsonSerializable()
class Attendance {
  String attendanceId;
  SubjectExaminee subjectExaminee;
  int position;
  DateTime? startTime;
  DateTime? finishTime;

  Attendance({
    required this.attendanceId,
    required this.subjectExaminee,
    required this.position,
    this.startTime,
    this.finishTime,
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
