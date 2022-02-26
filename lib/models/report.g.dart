// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      reportId: json['reportId'] as String,
      reporter:
          AccountAlternative.fromJson(json['repter'] as Map<String, dynamic>),
      reportedUser: AccountAlternative.fromJson(
          json['reportedUser'] as Map<String, dynamic>),
      examRoom: ExamRoom.fromJson(json['examRoom'] as Map<String, dynamic>),
      description: json['description'] as String,
      note: json['note'] as String,
      status: json['status'] as int,
      solution: json['solution'] as String,
      reportType: json['reportType'] as int,
      imageUrl: json['imageUrl'] as String,
      createdDate: json['createdDate'] as String,
      lastModifiedDate: json['lastModifiedDate'] as String,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'reportId': instance.reportId,
      'reporter': instance.reporter,
      'reportedUser': instance.reportedUser,
      'examRoom': instance.examRoom,
      'description': instance.description,
      'note': instance.note,
      'status': instance.status,
      'solution': instance.solution,
      'reportType': instance.reportType,
      'imageUrl': instance.imageUrl,
      'createdDate': instance.createdDate,
      'lastModifiedDate': instance.lastModifiedDate
    };
