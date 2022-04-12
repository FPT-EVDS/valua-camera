import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/enums/attempt_status.dart';
import 'package:valua_camera/models/attempt.dart';
part 'failed_attempt.g.dart';

@JsonSerializable()
class FailedAttempt {
  Attempt lastAttempt;
  AttemptStatus status;

  FailedAttempt({
    required this.lastAttempt,
    required this.status,
  });

  factory FailedAttempt.fromJson(Map<String, dynamic> json) =>
      _$FailedAttemptFromJson(json);
  Map<String, dynamic> toJson() => _$FailedAttemptToJson(this);
}
