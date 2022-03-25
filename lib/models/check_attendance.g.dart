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
      examinee:
          AccountAlternative.fromJson(json['examinee'] as Map<String, dynamic>),
      position: json['position'] as int,
      examRoom: ExamRoom.fromJson(json['examRoom'] as Map<String, dynamic>),
      attempts: json['attempts'] as List<dynamic>,
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
      'examinee': instance.examinee,
      'position': instance.position,
      'examRoom': instance.examRoom,
      'attempts': instance.attempts,
      'startTime': instance.startTime?.toIso8601String(),
      'finishTime': instance.finishTime?.toIso8601String(),
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModified': instance.lastModified.toIso8601String(),
    };

ExamRoom _$ExamRoomFromJson(Map<String, dynamic> json) => ExamRoom(
      examRoomId: json['examRoomId'] as String,
      examRoomName: json['examRoomName'] as String,
    );

Map<String, dynamic> _$ExamRoomToJson(ExamRoom instance) => <String, dynamic>{
      'examRoomId': instance.examRoomId,
      'examRoomName': instance.examRoomName,
    };
