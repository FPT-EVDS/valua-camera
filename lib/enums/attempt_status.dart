import 'package:json_annotation/json_annotation.dart';

enum AttemptStatus {
  @JsonValue(0)
  fail,
  @JsonValue(1)
  success,
}
