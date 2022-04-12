// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      attendanceId: json['attendanceId'] as String,
      subjectExaminee: SubjectExaminee.fromJson(
          json['subjectExaminee'] as Map<String, dynamic>),
      position: json['position'] as int,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      finishTime: json['finishTime'] == null
          ? null
          : DateTime.parse(json['finishTime'] as String),
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'attendanceId': instance.attendanceId,
      'subjectExaminee': instance.subjectExaminee,
      'position': instance.position,
      'startTime': instance.startTime?.toIso8601String(),
      'finishTime': instance.finishTime?.toIso8601String(),
    };

SubjectExaminee _$SubjectExamineeFromJson(Map<String, dynamic> json) =>
    SubjectExaminee(
      subjectExamineeId: json['subjectExamineeId'] as String,
      examinee:
          AccountAlternative.fromJson(json['examinee'] as Map<String, dynamic>),
      status: $enumDecode(_$SubjectExamineeStatusEnumMap, json['status']),
      removedReason: json['removedReason'] as String?,
    );

Map<String, dynamic> _$SubjectExamineeToJson(SubjectExaminee instance) =>
    <String, dynamic>{
      'subjectExamineeId': instance.subjectExamineeId,
      'examinee': instance.examinee,
      'status': _$SubjectExamineeStatusEnumMap[instance.status],
      'removedReason': instance.removedReason,
    };

const _$SubjectExamineeStatusEnumMap = {
  SubjectExamineeStatus.assigned: 1,
  SubjectExamineeStatus.unassigned: 2,
  SubjectExamineeStatus.exempted: 3,
};
