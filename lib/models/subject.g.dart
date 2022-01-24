// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return Subject(
    subjectId: json['subjectId'] as String,
    subjectName: json['beginTime'] as String,
    subjectCode: json['finishTime'] as String,
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'subjectCode': instance.subjectCode,
    };
