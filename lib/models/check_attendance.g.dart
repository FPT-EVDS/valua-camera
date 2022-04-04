// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAttendance _$CheckAttendanceFromJson(Map<String, dynamic> json) =>
    CheckAttendance(
      attendance:
          Attendance.fromJson(json['attendance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckAttendanceToJson(CheckAttendance instance) =>
    <String, dynamic>{
      'attendance': instance.attendance,
    };

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      attendanceId: json['attendanceId'] as String,
      subjectExaminee: SubjectExaminee.fromJson(
          json['subjectExaminee'] as Map<String, dynamic>),
      position: json['position'] as int,
      examRoom: ExamRoom.fromJson(json['examRoom'] as Map<String, dynamic>),
      attempts: (json['attempts'] as List<dynamic>)
          .map((e) => Attempt.fromJson(e as Map<String, dynamic>))
          .toList(),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      finishTime: json['finishTime'] == null
          ? null
          : DateTime.parse(json['finishTime'] as String),
      createdDate: DateTime.parse(json['createdDate'] as String),
      lastModified: DateTime.parse(json['lastModified'] as String),
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'attendanceId': instance.attendanceId,
      'subjectExaminee': instance.subjectExaminee,
      'position': instance.position,
      'examRoom': instance.examRoom,
      'attempts': instance.attempts,
      'startTime': instance.startTime?.toIso8601String(),
      'finishTime': instance.finishTime?.toIso8601String(),
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModified': instance.lastModified.toIso8601String(),
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

ExamRoom _$ExamRoomFromJson(Map<String, dynamic> json) => ExamRoom(
      examRoomId: json['examRoomId'] as String,
      examRoomName: json['examRoomName'] as String,
    );

Map<String, dynamic> _$ExamRoomToJson(ExamRoom instance) => <String, dynamic>{
      'examRoomId': instance.examRoomId,
      'examRoomName': instance.examRoomName,
    };
