// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamRoom _$ExamRoomFromJson(Map<String, dynamic> json) {
  return ExamRoom(
    examRoomId: json['examRoomId'] as String,
    examRoomName: json['examRoomName'] as String,
    shift: json['shift'] == null
        ? null
        : Shift.fromJson(json['shift'] as Map<String, dynamic>),
    staff: json['staff'] == null
        ? null
        : AuthUser.fromJson(json['staff'] as Map<String, dynamic>),
    attendances:
        Attendances.fromJson(json['attendances'] as Map<String, dynamic>),
    room: json['room'] == null
        ? null
        : Room.fromJson(json['room'] as Map<String, dynamic>),
    subject: json['subject'] == null
        ? null
        : Subject.fromJson(json['subject'] as Map<String, dynamic>),
    status: json['status'] as int,
    createdDate: json['createdDate'] as String,
    lastModifiedDate: json['lastModifiedDate'] as String,
  );
}

Map<String, dynamic> _$ExamRoomToJson(ExamRoom instance) => <String, dynamic>{
      'examRoomId': instance.examRoomId,
      'examRoomName': instance.examRoomId,
      'shift': instance.shift,
      'staff': instance.staff,
      'room': instance.room,
      'attendances': instance.attendances,
      'subject': instance.subject,
      'status': instance.status,
      'createdDate': instance.createdDate,
      'lastModifiedDate': instance.lastModifiedDate,
    };
