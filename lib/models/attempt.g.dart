// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attempt _$AttemptFromJson(Map<String, dynamic> json) => Attempt(
      attemptId: json['attemptId'] as String,
      imageUrl: json['imageUrl'] as String,
      result: json['result'] as int,
      attemptedTime: DateTime.parse(json['attemptedTime'] as String),
    );

Map<String, dynamic> _$AttemptToJson(Attempt instance) => <String, dynamic>{
      'attemptId': instance.attemptId,
      'imageUrl': instance.imageUrl,
      'result': instance.result,
      'attemptedTime': instance.attemptedTime.toIso8601String(),
    };
