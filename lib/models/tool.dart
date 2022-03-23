import 'package:json_annotation/json_annotation.dart';
part 'tool.g.dart';

@JsonSerializable()
class Tool {
  String toolId;
  String toolCode;
  String toolName;
  bool isActive;
  DateTime createdDate;
  DateTime lastModifiedDate;

  Tool({
    required this.toolId,
    required this.toolCode,
    required this.toolName,
    required this.isActive,
    required this.createdDate,
    required this.lastModifiedDate,
  });

  factory Tool.fromJson(Map<String, dynamic> json) => _$ToolFromJson(json);
  Map<String, dynamic> toJson() => _$ToolToJson(this);
}
