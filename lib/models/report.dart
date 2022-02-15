import 'package:json_annotation/json_annotation.dart';
part 'report.g.dart';

@JsonSerializable()
class Report {
  String reportId;
  String description;
  String note;
  int status;

  Report({
    required this.reportId,
    required this.description,
    required this.note,
    required this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
