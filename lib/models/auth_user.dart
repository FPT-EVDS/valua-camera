import 'package:json_annotation/json_annotation.dart';
part 'auth_user.g.dart';

@JsonSerializable()
class AuthUser {
  final String appUserId;
  final String email;
  final String fullName;
  final String? gender;
  final String role;
  final String? phoneNumber;
  final String? imageUrl;
  final bool? isActive;
  final String companyId;

  AuthUser({
    required this.appUserId,
    required this.email,
    required this.fullName,
    this.gender,
    required this.role,
    this.phoneNumber,
    this.imageUrl,
    this.isActive,
    required this.companyId,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
