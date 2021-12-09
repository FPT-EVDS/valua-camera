// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      appUserId: json['appUserId'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      gender: json['gender'],
      role: json['role'] as String,
      birthdate: json['birthdate'] as String,
      address: json['address'] as String,
      isActive: json['isActive'] as bool,
      phoneNumber: json['phoneNumber'] as String,
      imageUrl: json['imageUrl'] as String?,
      companyId: json['companyId'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'appUserId': instance.appUserId,
      'email': instance.email,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'role': instance.role,
      'birthdate': instance.birthdate,
      'address': instance.address,
      'isActive': instance.isActive,
      'phoneNumber': instance.phoneNumber,
      'imageUrl': instance.imageUrl,
      'companyId': instance.companyId,
      'refreshToken': instance.refreshToken,
    };
