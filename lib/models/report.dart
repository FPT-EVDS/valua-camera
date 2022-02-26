import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/account_alternative.dart';
import 'package:valua_camera/models/exam_room.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  String reportId;
  AccountAlternative reporter;
  AccountAlternative? reportedUser;
  ExamRoom examRoom;
  String description;
  String? note;
  int status;
  int reportType;
  String? solution;
  String? imageUrl;
  String createdDate;
  String lastModifiedDate;

  Report({
    required this.reportId,
    required this.reporter,
    this.reportedUser,
    required this.description,
    this.note,
    required this.status,
    required this.examRoom,
    required this.reportType,
    this.solution,
    this.imageUrl,
    required this.createdDate,
    required this.lastModifiedDate,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
