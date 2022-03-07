import 'package:json_annotation/json_annotation.dart';

enum AttendanceStatus {
  @JsonValue(1)
  pending,
  @JsonValue(2)
  present,
  @JsonValue(3)
  absent,
}
