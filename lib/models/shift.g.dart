// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shift _$ShiftFromJson(Map<String, dynamic> json) => Shift(
      shiftId: json['shiftId'] as String,
      beginTime: json['beginTime'] as String,
      finishTime: json['finishTime'] as String,
      shiftManager: AccountAlternative.fromJson(
          json['shiftManager'] as Map<String, dynamic>),
      status: $enumDecode(_$ShiftStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$ShiftToJson(Shift instance) => <String, dynamic>{
      'shiftId': instance.shiftId,
      'beginTime': instance.beginTime,
      'finishTime': instance.finishTime,
      'shiftManager': instance.shiftManager,
      'status': _$ShiftStatusEnumMap[instance.status],
    };

const _$ShiftStatusEnumMap = {
  ShiftStatus.removed: 0,
  ShiftStatus.finished: 1,
  ShiftStatus.locked: 2,
  ShiftStatus.ready: 3,
  ShiftStatus.notReady: 4,
  ShiftStatus.staffing: 5,
  ShiftStatus.ongoing: 6,
};
