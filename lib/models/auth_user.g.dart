// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) {
  return AuthUser(
    appUserId: json['appUserId'] as String,
    email: json['email'] as String,
    fullName: json['fullName'] as String,
    gender: json['gender'] as String?,
    role: json['role'] as String,
    phoneNumber: json['phoneNumber'] as String?,
    imageUrl: json['imageUrl'] as String?,
    isActive: json['isActive'] as bool?,
    companyId: json['companyId'] as String,
  );
}

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
      'appUserId': instance.appUserId,
      'email': instance.email,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'role': instance.role,
      'phoneNumber': instance.phoneNumber,
      'profileImageUrl': instance.imageUrl,
      'isActive': instance.isActive,
      'companyId': instance.companyId,
    };
