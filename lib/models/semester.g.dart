// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Semester _$SemesterFromJson(Map<String, dynamic> json) {
  return Semester(
    semesterId: json['semesterId'] as String,
    name: json['semesterName'] as String,
  );
}

Map<String, dynamic> _$SemesterToJson(Semester instance) => <String, dynamic>{
      'semesterId': instance.semesterId,
      'semesterName': instance.name,
    };
