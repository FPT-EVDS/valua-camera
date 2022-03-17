import 'package:json_annotation/json_annotation.dart';

enum ReportStatus {
  @JsonValue(1)
  pending,
  @JsonValue(2)
  resolved,
}
