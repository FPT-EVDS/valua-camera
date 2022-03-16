// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      reportId: json['reportId'] as String,
      reporter:
          AccountAlternative.fromJson(json['reporter'] as Map<String, dynamic>),
      reportedUser: json['reportedUser'] == null
          ? null
          : AccountAlternative.fromJson(
              json['reportedUser'] as Map<String, dynamic>),
      examRoom: ExamRoom.fromJson(json['examRoom'] as Map<String, dynamic>),
      description: json['description'] as String,
      note: json['note'] as String?,
      status: $enumDecode(_$ReportStatusEnumMap, json['status']),
      solution: json['solution'] as String?,
      reportType: $enumDecode(_$ReportTypeEnumMap, json['reportType']),
      imageUrl: json['imageUrl'] as String?,
      createdDate: DateTime.parse(json['createdDate'] as String),
      lastModifiedDate: DateTime.parse(json['lastModifiedDate'] as String),
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'reportId': instance.reportId,
      'reporter': instance.reporter,
      'reportedUser': instance.reportedUser,
      'examRoom': instance.examRoom,
      'description': instance.description,
      'note': instance.note,
      'status': _$ReportStatusEnumMap[instance.status],
      'solution': instance.solution,
      'reportType': _$ReportTypeEnumMap[instance.reportType],
      'imageUrl': instance.imageUrl,
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
    };

const _$ReportStatusEnumMap = {
  ReportStatus.pending: 1,
  ReportStatus.resolved: 2,
};

const _$ReportTypeEnumMap = {
  ReportType.incident: 1,
  ReportType.violation: 2,
};

ExamRoom _$ExamRoomFromJson(Map<String, dynamic> json) => ExamRoom(
      examRoomId: json['examRoomId'] as String,
      examRoomName: json['examRoomName'] as String,
      staff: AccountAlternative.fromJson(json['staff'] as Map<String, dynamic>),
      room: Room.fromJson(json['room'] as Map<String, dynamic>),
      subject: Subject.fromJson(json['subject'] as Map<String, dynamic>),
      status: json['status'] as int,
    );

Map<String, dynamic> _$ExamRoomToJson(ExamRoom instance) => <String, dynamic>{
      'examRoomId': instance.examRoomId,
      'examRoomName': instance.examRoomName,
      'staff': instance.staff,
      'room': instance.room,
      'subject': instance.subject,
      'status': instance.status,
    };
