// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      attendanceId: json['attendanceId'] as String,
      examinee:
          AccountAlternative.fromJson(json['examinee'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$AttendanceStatusEnumMap, json['status']),
      position: json['position'] as int,
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'attendanceId': instance.attendanceId,
      'examinee': instance.examinee,
      'status': _$AttendanceStatusEnumMap[instance.status],
      'position': instance.position,
    };

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.pending: 1,
  AttendanceStatus.present: 2,
  AttendanceStatus.absent: 3,
};
