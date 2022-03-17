// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrLoginResponse _$QrLoginResponseFromJson(Map<String, dynamic> json) =>
    QrLoginResponse(
      appUser: AppUser.fromJson(
          json['authenticationResponse'] as Map<String, dynamic>),
      status: json['status'] as bool,
    );

Map<String, dynamic> _$QrLoginResponseToJson(QrLoginResponse instance) =>
    <String, dynamic>{
      'authenticationResponse': instance.appUser,
      'status': instance.status,
    };
