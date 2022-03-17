// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_exam_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignedExamRoom _$AssignedExamRoomFromJson(Map<String, dynamic> json) =>
    AssignedExamRoom(
      currentRoom: Room.fromJson(json['currentRoom'] as Map<String, dynamic>),
      totalAttendances: json['totalAttendances'] as int,
      currentShift:
          Shift.fromJson(json['currentShift'] as Map<String, dynamic>),
      examRooms: (json['examRooms'] as List<dynamic>)
          .map((e) => ExamRoom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssignedExamRoomToJson(AssignedExamRoom instance) =>
    <String, dynamic>{
      'currentRoom': instance.currentRoom,
      'totalAttendances': instance.totalAttendances,
      'currentShift': instance.currentShift,
      'examRooms': instance.examRooms,
    };
