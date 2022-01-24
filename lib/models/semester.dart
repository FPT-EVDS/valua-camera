import 'package:json_annotation/json_annotation.dart';
part 'semester.g.dart';

@JsonSerializable()
class Semester {
  final String semesterId;
  final String name;

  const Semester({
    required this.semesterId,
    required this.name,
  });

  factory Semester.fromJson(Map<String, dynamic> json) =>
      _$SemesterFromJson(json);
  Map<String, dynamic> toJson() => _$SemesterToJson(this);
}
