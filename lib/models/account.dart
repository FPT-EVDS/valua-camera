import 'package:json_annotation/json_annotation.dart';
part 'account.g.dart';

@JsonSerializable()
class Account {
  String appUserId;
  String email;
  String fullName;
  String gender;
  String role;
  String birthdate;
  String address;
  bool isActive;
  String phoneNumber;
  String? imageUrl;
  String companyId;
  String refreshToken;

  Account({
    required this.appUserId,
    required this.email,
    required this.fullName,
    required this.gender,
    required this.role,
    required this.birthdate,
    required this.address,
    required this.isActive,
    required this.phoneNumber,
    this.imageUrl,
    required this.companyId,
    required this.refreshToken,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
