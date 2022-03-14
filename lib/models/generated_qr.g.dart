// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_qr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratedQR _$GeneratedQRFromJson(Map<String, dynamic> json) => GeneratedQR(
      data: QRData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool,
    );

Map<String, dynamic> _$GeneratedQRToJson(GeneratedQR instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

QRData _$QRDataFromJson(Map<String, dynamic> json) => QRData(
      token: json['token'] as String,
    );

Map<String, dynamic> _$QRDataToJson(QRData instance) => <String, dynamic>{
      'token': instance.token,
    };
