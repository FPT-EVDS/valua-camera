import 'package:json_annotation/json_annotation.dart';

enum ReportType {
  @JsonValue(1)
  incident,
  @JsonValue(2)
  violation,
}
