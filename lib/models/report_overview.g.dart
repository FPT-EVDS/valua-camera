// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportOverview _$ReportOverviewFromJson(Map<String, dynamic> json) =>
    ReportOverview(
      currentRoom: Room.fromJson(json['currentRoom'] as Map<String, dynamic>),
      currentShift:
          Shift.fromJson(json['currentShift'] as Map<String, dynamic>),
      reportsInExamRooms: (json['reportsInExamRooms'] as List<dynamic>)
          .map((e) => ReportsInExamRoom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportOverviewToJson(ReportOverview instance) =>
    <String, dynamic>{
      'currentRoom': instance.currentRoom,
      'currentShift': instance.currentShift,
      'reportsInExamRooms': instance.reportsInExamRooms,
    };

ReportsInExamRoom _$ReportsInExamRoomFromJson(Map<String, dynamic> json) =>
    ReportsInExamRoom(
      reports: (json['reports'] as List<dynamic>)
          .map((e) => Report.fromJson(e as Map<String, dynamic>))
          .toList(),
      examRoom: ExamRoom.fromJson(json['examRoom'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportsInExamRoomToJson(ReportsInExamRoom instance) =>
    <String, dynamic>{
      'reports': instance.reports,
      'examRoom': instance.examRoom,
    };

ExamRoom _$ExamRoomFromJson(Map<String, dynamic> json) => ExamRoom(
      examRoomId: json['examRoomId'] as String,
      examRoomName: json['examRoomName'] as String,
    );

Map<String, dynamic> _$ExamRoomToJson(ExamRoom instance) => <String, dynamic>{
      'examRoomId': instance.examRoomId,
      'examRoomName': instance.examRoomName,
    };

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      reportId: json['reportId'] as String,
      reportedUser: json['reportedUser'] == null
          ? null
          : AccountAlternative.fromJson(
              json['reportedUser'] as Map<String, dynamic>),
      solution: json['solution'] as String?,
      reportType: $enumDecode(_$ReportTypeEnumMap, json['reportType']),
      createdDate: DateTime.parse(json['createdDate'] as String),
      lastModifiedDate: DateTime.parse(json['lastModifiedDate'] as String),
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'reportId': instance.reportId,
      'reportedUser': instance.reportedUser,
      'solution': instance.solution,
      'reportType': _$ReportTypeEnumMap[instance.reportType],
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
    };

const _$ReportTypeEnumMap = {
  ReportType.incident: 1,
  ReportType.violation: 2,
};
