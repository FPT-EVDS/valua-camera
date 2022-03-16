import 'package:json_annotation/json_annotation.dart';

enum ShiftStatus {
  @JsonValue(0)
  removed,
  @JsonValue(1)
  finished,
  @JsonValue(2)
  locked,
  @JsonValue(3)
  ready,
  @JsonValue(4)
  notReady,
  @JsonValue(5)
  staffing,
  @JsonValue(6)
  ongoing,
}
