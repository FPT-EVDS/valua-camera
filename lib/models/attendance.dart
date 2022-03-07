import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/enums/attendance_status.dart';
import 'package:valua_camera/models/account_alternative.dart';

part 'attendance.g.dart';

@JsonSerializable()
class Attendance {
  String attendanceId;
  AccountAlternative examinee;
  AttendanceStatus? status;
  int position;

  Attendance({
    required this.attendanceId,
    required this.examinee,
    this.status,
    required this.position,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}
