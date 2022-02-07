import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/auth_user.dart';

part 'attendances.g.dart';

@JsonSerializable()
class Attendances {
  String attendanceId;
  AuthUser? examinee;
  int? status;
  int position;

  Attendances({
    required this.attendanceId,
    this.examinee,
    this.status,
    required this.position,
  });

  factory Attendances.fromJson(Map<String, dynamic> json) =>
      _$AttendancesFromJson(json);
  Map<String, dynamic> toJson() => _$AttendancesToJson(this);
}
