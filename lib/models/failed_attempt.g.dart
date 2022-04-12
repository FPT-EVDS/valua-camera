// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failed_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FailedAttempt _$FailedAttemptFromJson(Map<String, dynamic> json) =>
    FailedAttempt(
      lastAttempt:
          Attempt.fromJson(json['lastAttempt'] as Map<String, dynamic>),
      status: $enumDecode(_$AttemptStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$FailedAttemptToJson(FailedAttempt instance) =>
    <String, dynamic>{
      'lastAttempt': instance.lastAttempt,
      'status': _$AttemptStatusEnumMap[instance.status],
    };

const _$AttemptStatusEnumMap = {
  AttemptStatus.fail: 0,
  AttemptStatus.success: 1,
};
