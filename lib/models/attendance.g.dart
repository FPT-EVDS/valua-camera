// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      attendanceId: json['attendanceId'] as String,
      examinee: json['examinee'] == null
          ? null
          : AccountAlternative.fromJson(
              json['examinee'] as Map<String, dynamic>),
      status: json['status'] as int?,
      position: json['position'] as int,
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'attendanceId': instance.attendanceId,
      'examinee': instance.examinee,
      'status': instance.status,
      'position': instance.position,
    };
