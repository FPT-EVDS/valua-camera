// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      subjectId: json['subjectId'] as String,
      subjectName: json['subjectName'] as String,
      subjectCode: json['subjectCode'] as String,
      tools: (json['tools'] as List<dynamic>)
          .map((e) => Tool.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'subjectCode': instance.subjectCode,
      'tools': instance.tools,
    };
