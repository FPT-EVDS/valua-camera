import 'package:json_annotation/json_annotation.dart';

enum SubjectExamineeStatus {
  @JsonValue(1)
  assigned,
  @JsonValue(2)
  unassigned,
  @JsonValue(3)
  exempted,
}
