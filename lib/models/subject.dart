import 'package:json_annotation/json_annotation.dart';
part 'subject.g.dart';

@JsonSerializable()
class Subject {
  String subjectId;
  String subjectName;
  String subjectCode;

  Subject({
    required this.subjectId,
    required this.subjectName,
    required this.subjectCode,
  });

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
