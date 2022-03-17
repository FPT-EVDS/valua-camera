// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamRoom _$ExamRoomFromJson(Map<String, dynamic> json) => ExamRoom(
      examRoomId: json['examRoomId'] as String,
      examRoomName: json['examRoomName'] as String,
      subject: Subject.fromJson(json['subject'] as Map<String, dynamic>),
      attendances: (json['attendances'] as List<dynamic>)
          .map((e) => Attendance.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
      createdDate: DateTime.parse(json['createdDate'] as String),
      lastModifiedDate: DateTime.parse(json['lastModifiedDate'] as String),
    );

Map<String, dynamic> _$ExamRoomToJson(ExamRoom instance) => <String, dynamic>{
      'examRoomId': instance.examRoomId,
      'examRoomName': instance.examRoomName,
      'subject': instance.subject,
      'attendances': instance.attendances,
      'status': instance.status,
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
    };
