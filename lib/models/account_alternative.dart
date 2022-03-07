import 'package:json_annotation/json_annotation.dart';
part 'account_alternative.g.dart';

@JsonSerializable()
class AccountAlternative {
  String appUserId;
  String email;
  String fullName;
  String phoneNumber;
  String? imageUrl;
  String companyId;

  AccountAlternative({
    required this.appUserId,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.imageUrl,
    required this.companyId,
  });

  factory AccountAlternative.fromJson(Map<String, dynamic> json) =>
      _$AccountAlternativeFromJson(json);

  Map<String, dynamic> toJson() => _$AccountAlternativeToJson(this);
}
