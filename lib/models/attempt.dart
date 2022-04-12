import 'package:json_annotation/json_annotation.dart';
part 'attempt.g.dart';

@JsonSerializable()
class Attempt {
  String attemptId;
  String imageUrl;
  int result;
  DateTime attemptedTime;

  Attempt({
    required this.attemptId,
    required this.imageUrl,
    required this.result,
    required this.attemptedTime,
  });

  factory Attempt.fromJson(Map<String, dynamic> json) =>
      _$AttemptFromJson(json);
  Map<String, dynamic> toJson() => _$AttemptToJson(this);
}
