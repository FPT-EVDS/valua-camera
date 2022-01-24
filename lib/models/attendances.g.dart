// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendances.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendances _$AttendancesFromJson(Map<String, dynamic> json) {
  return Attendances(
    attendanceId: json['attendanceId'] as String,
    examinee: json['examinee'] == null
        ? null
        : AuthUser.fromJson(json['examinee'] as Map<String, dynamic>),
    position: json['position'] as int,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$AttendancesToJson(Attendances instance) =>
    <String, dynamic>{
      'attendanceId': instance.attendanceId,
      'examinee': instance.examinee,
      'status': instance.status,
      'position': instance.position,
    };
