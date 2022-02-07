// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_alternative.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountAlternative _$AccountAlternativeFromJson(Map<String, dynamic> json) =>
    AccountAlternative(
      appUserId: json['appUserId'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      imageUrl: json['imageUrl'] as String?,
      companyId: json['companyId'] as String,
    );

Map<String, dynamic> _$AccountAlternativeToJson(AccountAlternative instance) =>
    <String, dynamic>{
      'appUserId': instance.appUserId,
      'email': instance.email,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'imageUrl': instance.imageUrl,
      'companyId': instance.companyId,
    };
