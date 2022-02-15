// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      reportId: json['reportId'] as String,
      description: json['description'] as String,
      note: json['note'] as String,
      status: json['status'] as int,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'reportId': instance.reportId,
      'description': instance.description,
      'note': instance.note,
      'status': instance.status,
    };
