// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tool _$ToolFromJson(Map<String, dynamic> json) => Tool(
      toolId: json['toolId'] as String,
      toolCode: json['toolCode'] as String,
      toolName: json['toolName'] as String,
      isActive: json['isActive'] as bool,
      createdDate: DateTime.parse(json['createdDate'] as String),
      lastModifiedDate: DateTime.parse(json['lastModifiedDate'] as String),
    );

Map<String, dynamic> _$ToolToJson(Tool instance) => <String, dynamic>{
      'toolId': instance.toolId,
      'toolCode': instance.toolCode,
      'toolName': instance.toolName,
      'isActive': instance.isActive,
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
    };
