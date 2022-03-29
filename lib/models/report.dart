import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/enums/report_status.dart';
import 'package:valua_camera/enums/report_type.dart';
import 'package:valua_camera/models/account_alternative.dart';
import 'package:valua_camera/models/room.dart';
import 'package:valua_camera/models/subject_semester.dart';
part 'report.g.dart';

@JsonSerializable()
class Report {
  String reportId;
  AccountAlternative reporter;
  AccountAlternative? reportedUser;
  ExamRoom examRoom;
  String description;
  String? note;
  ReportStatus status;
  String? solution;
  ReportType reportType;
  String? imageUrl;
  DateTime createdDate;
  DateTime lastModifiedDate;

  Report({
    required this.reportId,
    required this.reporter,
    this.reportedUser,
    required this.examRoom,
    required this.description,
    this.note,
    required this.status,
    this.solution,
    required this.reportType,
    this.imageUrl,
    required this.createdDate,
    required this.lastModifiedDate,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}

@JsonSerializable()
class ExamRoom {
  String examRoomId;
  String examRoomName;
  AccountAlternative staff;
  Room room;
  SubjectSemester subjectSemester;
  int status;

  ExamRoom({
    required this.examRoomId,
    required this.examRoomName,
    required this.staff,
    required this.room,
    required this.subjectSemester,
    required this.status,
  });

  factory ExamRoom.fromJson(Map<String, dynamic> json) =>
      _$ExamRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ExamRoomToJson(this);
}
