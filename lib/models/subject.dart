import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/tool.dart';
part 'subject.g.dart';

@JsonSerializable()
class Subject {
  String subjectId;
  String subjectName;
  String subjectCode;
  List<Tool> tools;

  Subject({
    required this.subjectId,
    required this.subjectName,
    required this.subjectCode,
    required this.tools,
  });

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
