import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/account_alternative.dart';

part 'attendance.g.dart';

@JsonSerializable()
class Attendance {
  String attendanceId;
  AccountAlternative? examinee;
  int? status;
  int position;

  Attendance({
    required this.attendanceId,
    this.examinee,
    this.status,
    required this.position,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}
