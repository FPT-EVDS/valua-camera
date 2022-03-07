// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shift _$ShiftFromJson(Map<String, dynamic> json) => Shift(
      shiftId: json['shiftId'] as String,
      beginTime: json['beginTime'] as String,
      finishTime: json['finishTime'] as String,
    );

Map<String, dynamic> _$ShiftToJson(Shift instance) => <String, dynamic>{
      'shiftId': instance.shiftId,
      'beginTime': instance.beginTime,
      'finishTime': instance.finishTime,
    };
