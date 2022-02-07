// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      roomId: json['roomId'] as String,
      seatCount: json['seatCount'] as int,
      roomName: json['roomName'] as String,
      floor: json['floor'] as int,
      status: json['status'] as int,
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'roomId': instance.roomId,
      'seatCount': instance.seatCount,
      'roomName': instance.roomName,
      'floor': instance.floor,
      'status': instance.status,
    };
