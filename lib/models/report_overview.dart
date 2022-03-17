import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/enums/report_type.dart';
import 'package:valua_camera/models/account_alternative.dart';
import 'package:valua_camera/models/room.dart';
import 'package:valua_camera/models/shift.dart';
part 'report_overview.g.dart';

@JsonSerializable()
class ReportOverview {
  Room currentRoom;
  Shift currentShift;
  List<ReportsInExamRoom> reportsInExamRooms;

  ReportOverview({
    required this.currentRoom,
    required this.currentShift,
    required this.reportsInExamRooms,
  });

  factory ReportOverview.fromJson(Map<String, dynamic> json) =>
      _$ReportOverviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReportOverviewToJson(this);
}

@JsonSerializable()
class ReportsInExamRoom {
  List<Report> reports;
  ExamRoom examRoom;

  ReportsInExamRoom({
    required this.reports,
    required this.examRoom,
  });

  factory ReportsInExamRoom.fromJson(Map<String, dynamic> json) =>
      _$ReportsInExamRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ReportsInExamRoomToJson(this);
}

@JsonSerializable()
class ExamRoom {
  String examRoomId;
  String examRoomName;

  ExamRoom({
    required this.examRoomId,
    required this.examRoomName,
  });

  factory ExamRoom.fromJson(Map<String, dynamic> json) =>
      _$ExamRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ExamRoomToJson(this);
}

@JsonSerializable()
class Report {
  String reportId;
  AccountAlternative? reportedUser;
  String? solution;
  ReportType reportType;
  DateTime createdDate;
  DateTime lastModifiedDate;

  Report({
    required this.reportId,
    required this.reportedUser,
    required this.solution,
    required this.reportType,
    required this.createdDate,
    required this.lastModifiedDate,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
