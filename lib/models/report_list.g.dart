// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportList _$ReportListFromJson(Map<String, dynamic> json) => ReportList(
      totalItems: json['totalItems'] as int,
      totalPages: json['totalPages'] as int,
      reports: (json['reports'] as List<dynamic>)
          .map((e) => Report.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['currentPage'] as int,
    );

Map<String, dynamic> _$ReportListToJson(ReportList instance) =>
    <String, dynamic>{
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
      'reports': instance.reports,
      'currentPage': instance.currentPage,
    };
