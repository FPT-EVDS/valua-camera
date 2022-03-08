import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/report.dart';

part 'report_list.g.dart';

@JsonSerializable()
class ReportList {
  int totalItems;
  int totalPages;
  List<Report> reports;
  int currentPage;

  ReportList({
    required this.totalItems,
    required this.totalPages,
    required this.reports,
    required this.currentPage,
  });

  factory ReportList.fromJson(Map<String, dynamic> json) =>
      _$ReportListFromJson(json);

  Map<String, dynamic> toJson() => _$ReportListToJson(this);
}
